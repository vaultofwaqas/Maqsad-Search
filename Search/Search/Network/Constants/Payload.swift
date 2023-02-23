//
//  ServicePayload.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

struct Payload {
    
    private var endPoint: EndPoints
    private var parameters: [String: String]
    private var requestType: URLRequest.HTTPMethod
    
    init(endPoint: EndPoints,
         parameters: [String: String],
         requestType: URLRequest.HTTPMethod) {
        
        self.endPoint = endPoint
        self.parameters = parameters
        self.requestType = requestType
    }
    
    func getEndPoint() -> EndPoints {
        return endPoint
    }
    
    func getParameters() -> [String: String] {
        return parameters
    }
    
    func getBody() -> [String: String]? {
        if requestType == .get { return nil }
        return parameters
    }
    
    func getRequestType() -> URLRequest.HTTPMethod {
        return requestType
    }
    
    func getUrl() -> URL? {
        return ServiceUrls.getUrl(for: getEndPoint(),
                                queryParams: getParameters())
    }
}
