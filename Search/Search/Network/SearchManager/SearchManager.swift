//
//  SearchManager.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import Foundation

protocol SearchManagerProtocol {
    func searchAPI(payload: ServicePayload, searchText: String, completion: @escaping ResultHandler<(SearchBase, String)>)
}

class SearchManager: SearchManagerProtocol {
    
    func test() {}
    
    func searchAPI(payload: ServicePayload, searchText: String, completion: @escaping ResultHandler<(SearchBase, String)>) {
        let request = APIService<SearchBase>(success: { (data: SearchBase) -> Void in
            completion(.success((data, searchText)))
        }, failure: {
            completion(.failure)
        })
        request.makeCall(payload)
    }
}
