//
//  PostCell.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 7/31/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
class PostCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postPeriod: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profileImage.cornerRadius = CGFloat(self.profileImage.frame.size.height/2)
        self.postImage.cornerRadius = CGFloat((10/140) * self.postImage.frame.size.height)
        self.profileName.adjustsFontSizeToFitWidth = true
        self.postText.adjustsFontSizeToFitWidth = true
        self.postPeriod.adjustsFontSizeToFitWidth = true
        self.likeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.CommentButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }
}
