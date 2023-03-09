//
//  ServiceConstants.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

struct ServiceUrls {
    
    private static var baseUrl = "api.github.com" //"https://api.github.com/search/users"
}

extension ServiceUrls {
    static func getUrl(for endPoints: EndPoints, queryParams: [String: String]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = endPoints.getPath
        
        if let queryParams = queryParams {
            urlComponents.queryItems =  queryParams.map { (key, value) in
                return URLQueryItem(name: key, value: value)
            }
        }

        return urlComponents.url
    }
}
