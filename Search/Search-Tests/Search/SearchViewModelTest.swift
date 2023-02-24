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
        viewModel.user = mockUsers
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
        XCTAssert(viewModel.handlePaging(4, 17461) == false, "Failure Handle Paging")
    }
    
    func testSuccessPaging() {
        XCTAssert(viewModel.handlePaging(mockUsers.count, 17461) == true, "Success Handle Paging")
    }
    
    func testSuccessIsTextSimilar() {
        XCTAssert(viewModel.isTextSimilar("foo", "foo") == false, "Will update the list because the response is from the same searched text.")
    }
    
    func testFailureIsTextSimilar() {
        XCTAssert(viewModel.isTextSimilar("foo", "fo") == true, "Will noy update the list because response is not from the same searched text.")
    }
    
    func testInternetAvailability() {
        XCTAssert(isInternetAvailable() == true, "Internet should be available.")
    }
    
    func testSuccessDidChangeTextForSearch() {
        let searchText = viewModel.searchText
        viewModel.didChangeTextForSearch(text: "foo")
        XCTAssert(viewModel.searchText != searchText, "Text should update with search content")
    }
    
    func testFailureDidChangeTextForSearch() {
        let searchText = viewModel.searchText
        viewModel.didChangeTextForSearch(text: "fo")
        XCTAssert(viewModel.searchText == searchText, "Text should not update with search content")
    }
}
