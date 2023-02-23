//
//  UIImageView+Extension.swift
//  Search
//
//  Created by Waqas Khan on 23/02/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = AppColors.gray.cgColor
    }
}
