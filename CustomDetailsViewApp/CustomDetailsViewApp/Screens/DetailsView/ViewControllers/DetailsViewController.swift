//
//  DetailsViewController.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 7/24/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Cosmos
class DetailsViewController: UIViewController {

    @IBOutlet weak var overviewTabButton: UIButton!
    @IBOutlet weak var discussionTabButton: UIButton!
    @IBOutlet weak var customImage: customImageView!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var overViewView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceViewLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var publishingDateLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var publisherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.

        //priceLabel.setRoundedShadowPath()
        setViewHidden(view: self.postsTableView, hidden: true)
    }

    override func viewDidLayoutSubviews() {
        print("\(customImage.frame.size.width)")
        print("\(customImage.frame.size.height)")
        customImage.layoutSubviews()
        customImage.image = UIImage(named: "DSC02614.jpg")
        initUI()
    }
    func initUI() {
        overviewTabButton.cornerRadius = CGFloat(overviewTabButton.frame.size.height/2)
        discussionTabButton.cornerRadius = CGFloat(discussionTabButton.frame.size.height/2)
        priceView.cornerRadius = CGFloat(priceView.frame.size.height/2)
        priceView.shadowRadius = CGFloat((3/45) * priceView.frame.size.height)
        priceView.shadowOpacity = 0.3
        priceView.shadowColorValue = UIColor.black
        priceView.shadowOffsetValue = CGSize(width: CGFloat(1), height: CGFloat((2/45) * priceView.frame.size.height))
        priceView.maskToBounds = false
        publisherImage.cornerRadius = CGFloat(publisherImage.frame.size.height/2)
        priceViewLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.adjustsFontSizeToFitWidth = true
        movieGenre.adjustsFontSizeToFitWidth = true
        publishingDateLabel.adjustsFontSizeToFitWidth = true
        publisherNameLabel.adjustsFontSizeToFitWidth = true
    }
    func initConstraints() {
    }
    @IBAction func toggleAction(_ sender: Any) {
        if let toggleButton : UIButton = sender as? UIButton{
            if toggleButton.tag == 1{
                self.overviewTabButton.setTitleColor(UIColor.white, for: .normal)
                self.overviewTabButton.backgroundColor = UIColor(red: 74/256, green: 27/256, blue: 77/256, alpha: 1.0)
                self.discussionTabButton.setTitleColor(UIColor.lightGray, for: .normal)
                self.discussionTabButton.backgroundColor = UIColor.white
                setViewHidden(view: self.postsTableView, hidden: true)
                setViewHidden(view: self.overViewView, hidden: false)
            }else if toggleButton.tag == 2{
                self.discussionTabButton.setTitleColor(UIColor.white, for: .normal)
                self.discussionTabButton.backgroundColor = UIColor(red: 74/256, green: 27/256, blue: 77/256, alpha: 1.00)
                self.overviewTabButton.setTitleColor(UIColor.lightGray, for: .normal)
                self.overviewTabButton.backgroundColor = UIColor.white
                setViewHidden(view: self.overViewView, hidden: true)
                setViewHidden(view: self.postsTableView, hidden: false)
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewHidden(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
