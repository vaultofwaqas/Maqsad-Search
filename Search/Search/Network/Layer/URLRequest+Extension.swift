//
//  URLRequest+Extension.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

extension URLRequest {
    
    public init(url: URL,
                method: RequestMethod,
                header: [String: String]?,
                body: Any?,
                timeoutInterval: Double) {
        
        self.init(url: url)
        self.timeoutInterval = timeoutInterval
        
        self.method = method
        
        if let header = header {
            header.forEach { self.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        if let body = body {
            let httpBody: Data
            do {
                httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                self.httpBody = httpBody
            } catch {
                return
            }
        }
    }
}

extension URLRequest {
    
    /// HTTP request methods.
    public enum RequestMethod: String {
        /// HTTP GET
        case get = "GET"
        /// HTTP POST
        case post = "POST"
        /// HTTP PUT
        case put = "PUT"
        /// HTTP PATCH
        case patch = "PATCH"
        /// HTTP DELETE
        case delete = "DELETE"
        /// HTTP HEAD
        case head = "HEAD"
        /// HTTP OPTIONS
        case options = "OPTIONS"
        /// HTTP TRACE
        case trace = "TRACE"
        /// HTTP CONNECT
        case connect = "CONNECT"
    }

    public var method: RequestMethod? {
        get {
            guard let requestMethod = self.httpMethod else { return nil }
            let method = RequestMethod(rawValue: requestMethod)
            return method
        } set {
            self.httpMethod = newValue?.rawValue
        }
    }
}
