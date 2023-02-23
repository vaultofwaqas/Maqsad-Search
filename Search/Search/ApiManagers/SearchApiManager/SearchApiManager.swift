//
//  SearchManager.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import Foundation

protocol SearchApiManagerProtocol {
    func searchAPI(payload: Payload, searchText: String, completion: @escaping ResultHandler<([Search], String)>)
}

class SearchApiManager: SearchApiManagerProtocol {
    
    func searchAPI(payload: Payload, searchText: String, completion: @escaping ResultHandler<([Search], String)>) {
        
        let request = APIService { response in
            completion(.success((response.results ?? [], searchText)))
        } failure: { statusCode, message in
            completion(.failure(message ?? ""))
        }
        request.makeCall(payload)
    }
}
