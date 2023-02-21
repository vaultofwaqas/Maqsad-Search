//
//  Log.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

public enum Log {
    public static func debug(_ message: Any) {
        #if DEBUG
            print(message)
        #endif
    }
}
