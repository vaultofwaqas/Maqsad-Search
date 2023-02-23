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
    
    var isNil: Bool {
        return self == nil || self == ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Float {
    var orZero: Float {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Date {
    var orCurrent: Date {
        return self ?? Date()
    }
}
