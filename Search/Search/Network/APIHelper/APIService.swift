//
//  APIService.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

typealias ResultHandler<T> = (ResultType<T>) -> Void

enum ResultType<T> {
    case success(T)
    case failure
}

class APIService<T> where T: Codable {
    
    private let successCall: ((T) -> Void)
    private let failureCall: () -> Void
    
    let apiNetworkSession = APINetworkSession()
    let apiRequestDispatcher = APIRequestDispatcher<T>()
    
    init(success: @escaping (T) -> Void, failure: @escaping () -> Void) {
        self.successCall = success
        self.failureCall = failure
    }
}

extension APIService {
    
    func makeCall(_ payload: ServicePayload) {
        
        let url = ServiceConstants.baseUrl + payload.getEndPoint().methodName
        let urlWithPercentEscapes = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard let requestURL = URL(string: urlWithPercentEscapes.orNil) else {
            Log.debug("URL not created")
            return
        }
        
        let urlRequest = URLRequest(url: requestURL,
                                    method: payload.getRequestType(),
                                    header: payload.getHeaders(),
                                    body: payload.getParameters(),
                                    timeoutInterval: 15.0)
        
        executeCall(with: urlRequest)
    }
    
    private func executeCall(with request: URLRequest) {
        apiNetworkSession.dataTask(request, completionHandler: { [self] result in
            switch result {
            case .success(let response):
                Log.debug("------------------------------------------------")
                Log.debug("STATUS_CODE: \(response.response.statusCode)")
                Log.debug("ROUTE: \(request.url?.absoluteString ?? "")")
                Log.debug("METHOD: \(request.method ?? .get)")
                Log.debug("HEADERS: \(request.allHTTPHeaderFields?.getJsonFromDictionary ?? "")")
                
                if let parameter = request.httpBody?.getJSONFromData {
                    Log.debug("PARAMETERS: \(parameter)")
                }
                
                if let dataJsonResponse = response.data.getJSONFromData {
                    Log.debug(("RESPONSE: \(dataJsonResponse)"))
                }
                Log.debug("------------------------------------------------")
                
                let result = apiRequestDispatcher.parse(response.data)
                switch result {
                case .success(let apiResponse):
                    let requestResult = apiRequestDispatcher.verify(apiResponse: apiResponse, statuscode: response.response.statusCode)
                    switch requestResult {
                    case .success(let response):
                        handleSucessResponse(data: response)
                    case .failure(let error):
                        Log.debug(error)
                        failureCall()
                    }
                case .failure(let error):
                    Log.debug(error)
                    failureCall()
                }
            case .failure(let error):
                Log.debug(error)
                failureCall()
            }
        })
    }
    
    private func handleSucessResponse(data: T?) {
        guard let data = data else {
            failureCall()
            return
        }
        
        // MARK: Success From Server
        successCall(data)
    }
}
