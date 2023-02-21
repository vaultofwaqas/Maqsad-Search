//
//  SearchRouter.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

class SearchRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let storyboard = getStoryBoard(.search)
        let view = storyboard.instantiateViewController(ofType: SearchViewController.self)
        let router = SearchRouter()
        let viewModel = SearchViewModelImpl(router: router)
        
        view.viewModel = viewModel
        router.viewController = view

        return view
    }
}

// MARK: - Route Functions
extension SearchRouter {

}
