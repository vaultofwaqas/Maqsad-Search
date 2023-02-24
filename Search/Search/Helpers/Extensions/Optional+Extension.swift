//
//  Optional+Extension.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

extension Optional where Wrapped == String {
    var orNil: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}
