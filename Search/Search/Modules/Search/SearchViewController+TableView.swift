//
//  LaunchGood
//
//  Copyright © 2022 Bismillah Ar-Rahman Ar-Raheem. All rights reserved.
//

import UIKit

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

// MARK: - TableView DataSource
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - TableView Cells DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - TableView Cell Views
extension SearchViewController {
    
    func searchCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        return cell
    }
}
