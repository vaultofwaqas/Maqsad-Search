//
//  SearchViewModelTest.swift
//  Search-Tests
//
//  Created by Waqas Khan on 24/02/2023.
//

import XCTest
@testable import Search

final class SearchViewModelTest: XCTestCase {
    
    private let mockUsers = MockUsers().getUserViewModelData()
    private let viewModel = SearchViewModelImpl(router: SearchRouter())
    
    override func setUp() {
        super.setUp()
        viewModel.search = mockUsers
    }

    func testNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1, "Number of sections should be 1")
    }
    
    func testNumberOfRows() {
        XCTAssert(viewModel.numberOfRowsInSection(section: 1) == mockUsers.count, "Number of rows should be equal to mock Repositories count")
    }
    
    func testSearchTextIsEmpty() {
        XCTAssert(viewModel.isSearchTextEmpty(text: "") == "".isEmpty, "Search text is empty")
    }
    
    func testFailurePaging() {
        XCTAssert(viewModel.handlePaging(4) == false, "Failure Handle Paging")
    }
    
    func testSuccessPaging() {
        XCTAssert(viewModel.handlePaging(100) == true, "Success Handle Paging")
    }
}
