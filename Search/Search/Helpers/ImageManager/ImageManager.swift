//
//  ImageManager.swift
//  Search
//
//  Created by Waqas Khan on 23/02/2023.
//

import Foundation
import Kingfisher

class ImageManager {
    
    static func setImage(url: String, imageView: UIImageView) {
        guard !url.isEmpty,
              let urlString = url.trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let imgUrl = URL(string: urlString) else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imgUrl)
        imageView.layoutIfNeeded()
    }
}
