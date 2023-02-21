//
//  APIRequestDispatcher.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

/// Enum of API Errors
enum APIError: Error {
    /// No data received from the server.
    case noData
    /// The server response was unauthorized.
    case unauthorized(String?)
    /// The server response was validation error.
    case validation(String?)
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest
    /// Encoutered a server error.
    case serverError
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown
}

class APIRequestDispatcher<T> where T: Codable {
    
    func parse(_ data: Data?) -> Result<T, Error> {
        guard let data = data else { return .failure(APIError.invalidResponse) }
        do {
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(T.self, from: data)
            return .success(apiResponse)
        } catch let exception {
            return .failure(APIError.parseError("Parsable error: \(exception)"))
        }
    }
    
    func verify(apiResponse: T?, statuscode: Int) -> Result<T?, Error> {
        switch statuscode {
        case 200...299:
            if apiResponse == nil {
                return .failure(APIError.noData)
            }
            return .success(apiResponse)
        case 401:
            //Logout to login screen
            return .failure(APIError.unauthorized(""))
        case 422:
            return .failure(APIError.validation(""))
        case 400...499:
            return .failure(APIError.badRequest)
        case 500...599:
            return .failure(APIError.serverError)
        default:
            return .failure(APIError.unknown)
        }
    }
}
