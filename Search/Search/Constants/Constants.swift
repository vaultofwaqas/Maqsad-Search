//
//  Constant.swift
//  Search
//
//  Created by Waqas Khan on 24/02/2023.
//

import Foundation

enum Constants {
    
    enum SearchView {
        static let perPage = 9
        static var currentPage = 1
        static var totalCount = 0
    }
    
    enum ErrorTypes {
        static let noInternet = "Please check your device have an active internet connection."
        static let somethingWrong = "Something went wrong."
        static let error = "Error."
    }
}
