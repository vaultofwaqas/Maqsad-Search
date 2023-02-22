//
//  SearchViewModel.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//
import Foundation

typealias SearchViewModelViewSetup = (SearchViewModelImpl.ViewSetup) -> Void

protocol SearchViewModel {
    var viewSetup: SearchViewModelViewSetup? { get set }
    
    // MARK: - Variable Protocols
    var search: [Search] { get set }
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    func viewModelWillDisappear()
    
    // MARK: - Route Protocols
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
    func clearSearchResults()
    func isSearchTextEmpty(text: String?) -> Bool
    func didChangeTextForSearch(text: String)
    func handlePaging(_ itemCount: Int) -> Bool
}

class SearchViewModelImpl {

    private let router: SearchRouter
    
    var viewSetup: SearchViewModelViewSetup?
    
    // MARK: - Variables
    var searchManager: SearchManagerProtocol!
    var search: [Search] = []
    
    var searchText = ""
    var perPage: Int = 9
    var currentPage: Int = 1
    let pageLimit: Int = 1000
    
    // MARK: - Initializer
    init(router: SearchRouter) {
        self.router = router
        searchManager = SearchManager()
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
        case showSuccessMessage(withMessage: String)
        case showErrorMessage(withMessage: String)
        case reloadView
    }
}

// MARK: - Lifecycle Functions
extension SearchViewModelImpl: SearchViewModel {
    func viewModelDidLoad() {
        viewSetup?(.setupNavigation)
        viewSetup?(.setupView)
    }
    
    func viewModelWillAppear() {}
    
    func viewModelWillDisappear() {}
}

// MARK: - Route Functions
extension SearchViewModelImpl {

}

// MARK: - API Functions
extension SearchViewModelImpl {
    // Search API
    func setSearchPayload(searchText: String, perPage: Int, page: Int) -> ServicePayload {
        let payload = ServicePayload(apiEndpoint: .searchResults(searchText, perPage, page), requestType: .get)
        return payload
    }
    
    func searchAPI(_ withPayload: ServicePayload, _ searchText: String) {
        if search.isEmpty { viewSetup?(.showLoader) }
        searchManager.searchAPI(payload: withPayload, searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            self.viewSetup?(.hideLoader)
            switch result {
            case .success(let (search, text)):
                if searchText != text { return }
                DispatchQueue.main.async {
                    self.search.append(contentsOf: search.items)
                    self.viewSetup?(.reloadView)
                }
            case .failure: break
            }
        }
    }
}

// MARK: - Logic Functions
extension SearchViewModelImpl {
    
    func clearSearchResults() {
        search = []
        viewSetup?(.reloadView)
    }
    
    func isSearchTextEmpty(text: String?) -> Bool {
        return text.orNil.isEmpty
    }
    
    func didChangeTextForSearch(text: String) {
        if text.count >= 3 {
            //APICALL
            searchText = text
            searchAPI(setSearchPayload(searchText: text, perPage: perPage, page: currentPage), text)
        }
    }
    
    func handlePaging(_ itemCount: Int) -> Bool {
        if itemCount == search.count {
            if currentPage < pageLimit {
                currentPage += 1
                searchAPI(setSearchPayload(searchText: searchText, perPage: perPage, page: currentPage), searchText)
                return true
            }
        }
        return false
    }

}
