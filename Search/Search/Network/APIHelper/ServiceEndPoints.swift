//
//  ServiceEndPoints.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//


import Foundation

enum ServiceEndPoints {

    case test(Test)
    
    var methodName: String {
        switch self {
        case .test(let test):
            return test.rawValue
        }
    }
}

/*========================================================================*/

enum Test: String {
    case test = ""
}
