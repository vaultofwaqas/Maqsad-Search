//
//  MockUsers.swift
//  Search-Tests
//
//  Created by Waqas Khan on 23/02/2023.
//

import XCTest
@testable import Search

final class MockUsers: XCTestCase {
    
    func getUserViewModelData() -> [Search] {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "Users", ofType: "json") else {
            fatalError()
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ApiResponse<[Search]>.self, from: data)
            return response.results ?? []
        } catch {
            print("error:\(error.localizedDescription)")
            fatalError()
        }
    }

}
