//
//  NSObject+Extensions.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return self.className
    }
}

extension NSObject: ClassNameProtocol {}
