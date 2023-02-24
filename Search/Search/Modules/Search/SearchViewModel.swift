//
//  SearchViewModel.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//
import Foundation

typealias SearchViewModelViewSetup = (SearchViewModelImpl.ViewSetup) -> Void

enum Params: String {
    case page = "page"
    case perPage = "per_page"
    case query = "q"
}

protocol SearchViewModel {
    var viewSetup: SearchViewModelViewSetup? { get set }
    
    // MARK: - Variable Protocols
    var search: [Search] { get set }
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    
    func clearSearchResults()
    func isSearchTextEmpty(text: String?) -> Bool
    func didChangeTextForSearch(text: String)
    func handlePaging(_ itemCount: Int) -> Bool
}

class SearchViewModelImpl {

    private let router: SearchRouter
    
    var viewSetup: SearchViewModelViewSetup?
    
    // MARK: - Variables
    var searchManager: SearchApiManagerProtocol!
    var search: [Search] = []
    
    var searchText = ""
    
    // MARK: - Initializer
    init(router: SearchRouter) {
        self.router = router
        searchManager = SearchApiManager()
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
        case removeBottomSpinner
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
}

// MARK: - API Functions
extension SearchViewModelImpl {
    
    // Search API
    func getParams() -> [String: String] {
        return [Params.query.rawValue: "\(searchText)",
                Params.perPage.rawValue: "\(Constants.SearchView.perPage)",
                Params.page.rawValue: "\(Constants.SearchView.currentPage)"]
    }
    
    func setSearchPayload(searchText: String, perPage: Int, page: Int) -> Payload {
        let payload = Payload(endPoint: .search(.users), parameters: getParams(), requestType: .get)
        return payload
    }
    
    func searchAPI(_ withPayload: Payload, _ searchText: String) {
        if search.isEmpty { viewSetup?(.showLoader) }
        searchManager.searchAPI(payload: withPayload, searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            self.viewSetup?(.hideLoader)
            switch result {
            case .success(let (search, text)):
                if self.isTextSimilar(searchText, text) { return }
                self.showSuccess(with: search)
            case .failure(let message):
                self.showError(with: message)
            }
        }
    }
}

// MARK: - Logic Functions
extension SearchViewModelImpl {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return search.count
    }
    
    func clearSearchResults() {
        search = []
        Constants.SearchView.currentPage = 1
        viewSetup?(.reloadView)
    }
    
    func isSearchTextEmpty(text: String?) -> Bool {
        return text.orNil.isEmpty
    }
    
    func didChangeTextForSearch(text: String) {
        if text.count >= 3 {
            //APICALL
            searchText = text
            searchAPI(setSearchPayload(searchText: text,
                                       perPage: Constants.SearchView.perPage,
                                       page: Constants.SearchView.currentPage),
                      text)
        }
    }
    
    func handlePaging(_ itemCount: Int) -> Bool {
        if itemCount == search.count {
            if Constants.SearchView.currentPage < Constants.SearchView.pageLimit {
                Constants.SearchView.currentPage += 1
                searchAPI(setSearchPayload(searchText: searchText,
                                           perPage: Constants.SearchView.perPage,
                                           page: Constants.SearchView.currentPage),
                          searchText)
                return true
            }
        }
        return false
    }
    
    func isTextSimilar(_ currentText: String, _ responseText: String) -> Bool {
        return currentText != responseText
    }
    
    func showSuccess(with response: [Search]) {
        DispatchQueue.main.async { [self] in
            search.append(contentsOf: response)
            viewSetup?(.reloadView)
        }
    }
    
    func showError(with message: String) {
        DispatchQueue.main.async { [self] in
            viewSetup?(.removeBottomSpinner)
            switch !isInternetAvailable() {
            case true:
                showToast(with: Constants.ErrorTypes.noInternet)
            case false:
                showToast(with: Constants.ErrorTypes.somethingWrong)
            }
        }
    }
    
    func showToast(with message: String) {
        Toast.showError(with: message)
    }

}
