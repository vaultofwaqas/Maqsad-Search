//
//  ApiResponse.swift
//  Search
//
//  Created by Waqas Khan on 23/02/2023.
//

import Foundation

struct ApiResponse<T>: Codable where T: Codable {

    var message: String?
    var results: T?
    var totalCount: Int?
    var incompleteResults: Bool?

    enum CodingKeys: String, CodingKey {
        case results = "items"
        case message = "message"
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }

    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            results = try values.decodeIfPresent(T.self, forKey: .results)
            totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
            incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        } catch let DecodingError.typeMismatch(type, context) {
            logger("Type '\(type)' mismatch: \(context.debugDescription)")
            logger("codingPath: \(context.codingPath)")
        } catch {
            logger(error)
            logger(error.localizedDescription)
        }
    }
}
