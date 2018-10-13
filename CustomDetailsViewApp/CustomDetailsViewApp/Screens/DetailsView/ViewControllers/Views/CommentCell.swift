
//
//  File.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 8/1/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
class CommentCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profileImage.cornerRadius = CGFloat(self.profileImage.frame.size.height/2)
    }
}
