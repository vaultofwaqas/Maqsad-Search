//
//  APIRequestDispatcher.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation

/// Enum of API Errors
enum APIError: Error {
    /// Success
    case success
    /// No Internet Connection
    case noInternet
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
    
    func parse(_ data: Data?) -> Result<ApiResponse<T>, Error> {
        guard let data = data else { return .failure(APIError.invalidResponse) }
        do {
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(ApiResponse<T>.self, from: data)
            return .success(apiResponse)
        } catch let exception {
            return .failure(APIError.parseError("Parsable error: \(exception)"))
        }
    }
}

// MARK: Some Of The Assumed Status Code, Can Be Changed Based Upon Current Server Config.
extension Int {
    var status: APIError {
        switch self {
        case 200...299:
            return .success
        case 401:
            return .unauthorized("")
        case 422:
            return .validation("")
        case 400...499:
            return .badRequest
        case 500...599:
            return .serverError
        default:
            return .unknown
        }
    }
}
