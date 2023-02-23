//
//  NavigationManager.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

// MARK: A Struct Is Used Here To Get Control and Start The App Programatically
struct NavigationManager {
    
    // MARK: Variable
    var window: UIWindow
    
    // MARK: Internal
    static var instance: NavigationManager?
    
    // MARK: Lifecycle
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func initialize(with scene: UIWindowScene) {
        instance = NavigationManager(window: makeNewWindow(from: scene))
        instance?.bootstrap()
    }
    
    // MARK: - Make Window
    private static func makeNewWindow(from scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = .white
        SceneDelegate.setUIWindow(window)
        return window
    }
    
    // MARK: - Decision point to show Onboarding, Login, Home etc.
    mutating func bootstrap() {
        showSearchView()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Load Search
    private func showSearchView() {
        let controller = SearchRouter.createModule()
        self.window.rootViewController = controller
    }
}
