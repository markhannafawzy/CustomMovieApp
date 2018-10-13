//
//  MovieCell.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class MovieCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    func display(url: URL) {
        let placeHolderImage = UIImage(named: "Zootopia.jpg")
        self.posterImageView.kf.setImage(with: url, placeholder: placeHolderImage)
    }
    
    func display(title: String) {
        self.movieName.text = title
    }
}
