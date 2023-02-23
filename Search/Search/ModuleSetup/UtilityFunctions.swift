//
//  Shortcuts.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//

import Foundation
import UIKit

func getStoryBoard(_ storyBoard: StoryBoard) -> UIStoryboard {
    return UIStoryboard(name: storyBoard.rawValue, bundle: nil)
}

func logger(_ log: Any) {
    #if DEBUG
    print(log)
    #endif
}
