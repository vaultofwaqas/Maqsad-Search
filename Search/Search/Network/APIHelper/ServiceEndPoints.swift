//
//  ServiceEndPoints.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//


import Foundation

enum ServiceEndPoints {

    case searchResults(_ searchText: String, _ perPage: Int, _ page: Int)
    case test
    
    var methodName: String {
        switch self {
        case .searchResults(let searchText, let perPage, let page):
            return "?q=\(searchText)&per_page=\(perPage)&page=\(page)"
        case .test:
            return ""
        }
    }
}
