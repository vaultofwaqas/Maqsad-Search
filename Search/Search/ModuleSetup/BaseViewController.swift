//
//  BaseViewController.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import UIKit

public class BaseViewController: UIViewController {
    public func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    public func setupView() {}

    public func showLoader() {}
    
    public func hideLoader() {}

    public func showSuccessMessage(_: String) {}
    
    public func showErrorMessage(_: String) {}
}
