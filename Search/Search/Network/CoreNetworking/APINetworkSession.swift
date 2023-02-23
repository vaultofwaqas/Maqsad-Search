//
//  APINetworkSession.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

public typealias URLResponse = Result<(data: Data, response: HTTPURLResponse), Error>

class APINetworkSession {
    
    public init() {}
    
    func dataTask(_ request: URLRequest, completionHandler: @escaping (URLResponse) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse {
                completionHandler(.success((data, response)))
            } else {
                let error = error ?? NSError(domain: "Error", code: -1, userInfo: [:])
                completionHandler(.failure(error))
            }
        }
        dataTask.resume()
    }
}
