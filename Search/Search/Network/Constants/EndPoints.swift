//
//  EndPoints.swift
//  Search
//
//  Created by Waqas Khan on 23/02/2023.
//

import Foundation

// MARK: Main Paths
enum EndPoints {
    case search(SearchPath)
}

extension EndPoints {
    var getPath: String {
        switch self {
        case .search(let searchText):
            return "/search" + searchText.rawValue
        }
    }
}

// MARK: Sub Paths
enum SearchPath: String {
    case users = "/users"
}
