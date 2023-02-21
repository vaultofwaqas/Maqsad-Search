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
    
    // MARK: - Lifecycle Protocols
    func viewModelDidLoad()
    func viewModelWillAppear()
    func viewModelWillDisappear()
    
    // MARK: - Route Protocols
    
    // MARK: - API Protocols
    
    // MARK: - Logic Protocols
    func isSearchTextEmpty(text: String?) -> Bool
    func didChangeTextForSearch(text: String)
}

class SearchViewModelImpl {

    private let router: SearchRouter
    
    var viewSetup: SearchViewModelViewSetup?
    
    // MARK: - Variables
    
    // MARK: - Initializer
    init(router: SearchRouter) {
        self.router = router
    }
    
    // MARK: - For all of your viewBindings
    enum ViewSetup {
        case setupNavigation
        case setupView
        case showLoader
        case hideLoader
        case showSuccessMessage(withMessage: String)
        case showErrorMessage(withMessage: String)
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

}

// MARK: - Logic Functions
extension SearchViewModelImpl {
    
    func isSearchTextEmpty(text: String?) -> Bool {
        return text.orNil.isEmpty
    }
    
    func didChangeTextForSearch(text: String) {
        if text.count >= 3 {
            //APICALL
        }
    }

}
