//
//  ServicePayload.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

class PayloadBuilder {
    
    private var endPoint: EndPoints?
    private var parameters: [String: String]?
    private var requestType: URLRequest.HTTPMethod?
    
    func setEndPoint(_ endPoint: EndPoints) {
        self.endPoint = endPoint
    }
    
    func setParameters(_ parameters: [String: String]) {
        self.parameters = parameters
    }
    
    func setRequestType(_ requestType: URLRequest.HTTPMethod) {
        self.requestType = requestType
    }
    
    func build() -> Payload {
        return Payload(endPoint: endPoint ?? .empty,
                       parameters: parameters,
                       requestType: requestType ?? .get)
    }
}

struct Payload {
    
    public var endPoint: EndPoints
    public var parameters: [String: String]?
    public var requestType: URLRequest.HTTPMethod
    
    func getUrl() -> URL? {
        return ServiceUrls.getUrl(for: endPoint,
                                  queryParams: parameters)
    }
}
