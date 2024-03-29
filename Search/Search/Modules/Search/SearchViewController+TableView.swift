//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import UIKit

// MARK: - TableView Delegate, DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    // MARK: - TableView Cells DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: viewModel.numberOfSections())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch viewModel.handlePaging(indexPath.item + 1, Constants.SearchView.totalCount) {
        case true: addBottomSpinner()
        case false: removeBottomSpinner()
        }
    }
}

// MARK: - TableView Cell Views
extension SearchViewController {
    
    func userCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UserCell.self, for: indexPath)
        cell.bind(viewModel.user[indexPath.row])
        return cell
    }
}
