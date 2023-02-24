//
//  SearchViewControllerTest.swift
//  Search-Tests
//
//  Created by Waqas Khan on 23/02/2023.
//

import XCTest
@testable import Search

final class SearchViewControllerTest: XCTestCase {

    private let mockUsers = MockUsers().getUserViewModelData()
    let viewController = SearchRouter.createModule() as! SearchViewController
    
    override func setUp() {
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.viewModel.user = mockUsers
    }
    
    func testTableViewAndDelegates() {
        XCTAssert(viewController.tableviewSearch != nil, "Table view should be there")
        XCTAssert(viewController.tableviewSearch.delegate is SearchViewController, "Table view delegate should be set")
        XCTAssert(viewController.tableviewSearch.dataSource is SearchViewController, "Table view datasource should be set")
    }
    
    func testNumberOfSections() {
        XCTAssert(viewController.numberOfSections(in: viewController.tableviewSearch) == viewController.viewModel.numberOfSections(),
                  "Number of sections should be equal to what view model provides")
    }
    
    func testNumberOfRows() {
        XCTAssert(viewController.tableView(viewController.tableviewSearch, numberOfRowsInSection: 1) == viewController.viewModel.numberOfRowsInSection(section: 1),
                  "Number of rows should be equal to what view model provides")
    }
    
    func testCellForRow() {
        let cell = viewController.tableView(viewController.tableviewSearch, cellForRowAt: IndexPath.init(row: 0, section: 1))
        XCTAssert(cell is UserCell, "Cell should be SearchCell")
    }
    
    func testSearchCell() {
        let cell = viewController.userCell(viewController.tableviewSearch, indexPath: IndexPath.init(row: 0, section: 1))
        XCTAssert(cell is UserCell, "Cell should be SearchCell")
    }
}
