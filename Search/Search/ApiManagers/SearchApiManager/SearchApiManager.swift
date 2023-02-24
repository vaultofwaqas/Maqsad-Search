//
//  SearchManager.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import Foundation

protocol SearchApiManagerProtocol {
    func searchAPI(payload: Payload, searchText: String, completion: @escaping ResultHandler<([User], String)>)
}

class SearchApiManager: SearchApiManagerProtocol {
    
    func searchAPI(payload: Payload, searchText: String, completion: @escaping ResultHandler<([User], String)>) {
        
        let request = APIService<[User]> { response in
            Constants.SearchView.totalCount = response.totalCount.orZero
            completion(.success((response.results ?? [], searchText)))
        } failure: { statusCode, message in
            completion(.failure(message ?? ""))
        }
        request.makeCall(payload)
    }
}
