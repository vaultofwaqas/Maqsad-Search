//
//  SceneDelegate.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        NavigationManager.initialize(with: windowScene)
    }
}

extension SceneDelegate {
    final class func setUIWindow(_ window: UIWindow) {
        guard let connectedScene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = connectedScene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window = window
    }
}
