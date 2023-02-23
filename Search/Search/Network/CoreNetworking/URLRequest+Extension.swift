//
//  URLRequest+Extension.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

extension URLRequest {

    public init(url: URL?, method: HTTPMethod, header: [String: String]?, body: Any?) {

        guard let requestURL = url else { fatalError("URL not found") }

        logger("Last Called URL: \(requestURL)")
        logger("Last Called Para: \(body ?? "")")

        self.init(url: requestURL)
        self.timeoutInterval = 30.0

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

    public enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
    }

    public var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else {
                return nil
            }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }
        set {
            self.httpMethod = newValue?.rawValue
        }
    }
}
