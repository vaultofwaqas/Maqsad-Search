//
//  Toast.swift
//  Search
//
//  Created by Waqas Khan on 24/02/2023.
//

import Foundation
import UIKit
import Loaf

final class Toast {

    @discardableResult final class func showError(with message: String) -> Bool {
        guard let viewController = UIApplication.topViewController() else {
            return false
        }
        let message = message
        Loaf(message, state: .error, sender: viewController).show()
        return true
    }
}
