//
//  ServicePayload.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

struct ServicePayload {
    
    private var apiEndpoint: ServiceEndPoints?
    private var parameters: [String: Any]?
    private var requestType: URLRequest.RequestMethod?
    
    init(apiEndpoint: ServiceEndPoints? = nil,
         parameters: [String : Any]? = nil,
         requestType: URLRequest.RequestMethod? = nil) {
        
        self.apiEndpoint = apiEndpoint
        self.parameters = parameters
        self.requestType = requestType
    }
    
    func getEndPoint() -> ServiceEndPoints {
        return apiEndpoint ?? .test(.test)
    }

    func getParameters() -> [String: Any]? {
        return parameters ?? [:]
    }
    
    func getRequestType() -> URLRequest.RequestMethod {
        return requestType ?? .get
    }
    
    func getHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        headers["accept"] = "*/*"
        headers["Authorization"] = "bearer "
        return headers
    }
}
