//
//  UIStoryboard+Extension.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateViewController controller unwrapped failed")
            fatalError("Controller error")
        }
        return controller
    }
}
