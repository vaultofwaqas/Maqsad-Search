//
//  NavigationManager.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

struct NavigationManager {
    
    // MARK: Variable
    var window: UIWindow
    
    // MARK: Lifecycle
    private init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Internal
    static var instance: NavigationManager?
    
    static func initialize() {
        instance = NavigationManager(window: getSceneWindow())
        instance?.bootstrap()
    }
    
    // MARK: - Decision point to show Onboarding, Login, Home.
    mutating func bootstrap() {
        showSearchView()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Load Splash
    private func showSearchView() {
        let controller = SearchRouter.createModule()
        self.window.rootViewController = controller
    }
}
