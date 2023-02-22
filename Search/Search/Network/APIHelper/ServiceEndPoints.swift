//
//  ServiceEndPoints.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//


import Foundation

enum ServiceEndPoints {

    case searchResults(_ searchText: String)
    case test
    
    var methodName: String {
        switch self {
        case .searchResults(let searchText):
            return "?q=\(searchText)"
        case .test:
            return ""
        }
    }
}
