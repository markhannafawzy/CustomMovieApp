//
//  ViewController.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 7/27/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customImage: customImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customImage.setNeedsLayout()
        customImage.image = UIImage(named: "turquoise.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

