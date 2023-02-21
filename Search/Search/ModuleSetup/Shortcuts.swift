//
//  Shortcuts.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

func getSceneWindow() -> UIWindow {
    var window: UIWindow?
    
    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
        window = sceneDelegate.window
    }
    
    return window ?? UIWindow(frame: UIScreen.main.bounds)
}

func getStoryBoard(_ storyBoard: StoryBoard) -> UIStoryboard {
    return UIStoryboard(name: storyBoard.rawValue, bundle: nil)
}
