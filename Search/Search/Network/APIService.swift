//
//  APIService.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

class APIService<T> where T: Codable {
    
    private let success: (_ response: ApiResponse<T>) -> Void
    private let failure: (_ statusCode: APIError, _ message: String?) -> Void
    
    let apiNetworkSession = APINetworkSession()
    let apiRequestDispatcher = APIRequestDispatcher<T>()
    
    init(success: @escaping (_ response: ApiResponse<T>) -> Void,
         failure: @escaping (_ statusCode: APIError, _ message: String?) -> Void) {
        
        self.success = success
        self.failure = failure
    }
}

extension APIService {
    
    func makeCall(_ payload: Payload) {
        
        let urlRequest = URLRequest(url: payload.getUrl(),
                                    method: payload.requestType,
                                    header: nil,
                                    body: payload.parameters)
        
        executeCall(with: urlRequest)
    }
    
    private func executeCall(with request: URLRequest) {
        apiNetworkSession.dataTask(request, completionHandler: { [self] result in
            switch result {
            case .success(let response):
                
                // MARK: For Debugging: The Code Snippet Helps to Print Raw JSON Before We try to decode it
                /*if let jsonString = String(data: response.data, encoding: .utf8) {
                 logger("FOR DEBUGGING RAW JSON REPONSE")
                 logger("Status Code: \(response.response.statusCode)")
                 logger(jsonString)
                 }*/
                
                let statusCode = response.response.statusCode.status
                
                let result = apiRequestDispatcher.parse(response.data)
                switch result {
                case .success(let apiResponse):
                    switch statusCode {
                    case .success:
                        handleSuccessResponse(apiResponse, data: apiResponse.results)
                    default:
                        handleFailureResponse(statusCode, apiResponse)
                    }
                case .failure(let error):
                    logger(error)
                    failure(.unknown, error.localizedDescription)
                }
            case .failure(let error):
                logger(error.localizedDescription)
                failure(.unknown, error.localizedDescription)
            }
        })
    }
}

/*========================================================================*/
extension APIService {
    
    private func handleSuccessResponse(_ response: ApiResponse<T>, data: T?) {
        guard let _ = data else { return }
        // MARK: Success From Server
        success(response)
    }
    
    private func handleFailureResponse(_ status: APIError?, _ response: ApiResponse<T>?) {
        guard let status = status, let message = response?.message else {
            failure(.unknown, nil)
            return
        }
        failure(status, message)
    }
}
/*========================================================================*/
