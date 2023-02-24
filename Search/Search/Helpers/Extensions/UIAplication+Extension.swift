//
//  UIAplication+Extension.swift
//  Search
//
//  Created by Waqas Khan on 24/02/2023.
//

import UIKit

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = NavigationManager.instance?.window.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        return controller
    }
    
}
