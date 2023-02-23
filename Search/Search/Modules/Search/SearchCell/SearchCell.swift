//
//  SearchCell.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var imageSearch: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageSearch.roundedImage()
    }
    
    public func bind(_ search: Search) {
        labelType.text = search.type
        labelLogin.text = search.login
        ImageManager.setImage(url: search.avatarURL, imageView: imageSearch)
    }
}
