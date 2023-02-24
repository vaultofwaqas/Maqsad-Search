//
//  SearchCell.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var imageSearch: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageSearch.roundedImage()
    }
    
    public func bind(_ user: User) {
        labelType.text = user.type
        labelLogin.text = user.login
        ImageManager.setImage(url: user.avatarURL, imageView: imageSearch)
    }
}
