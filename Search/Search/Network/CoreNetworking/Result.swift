//
//  Result.swift
//  Search
//
//  Created by Waqas Khan on 23/02/2023.
//

import Foundation

typealias ResultHandler<T> = (ResultType<T>) -> Void

enum ResultType<T> {
    case success(T)
    case failure(String)
}
