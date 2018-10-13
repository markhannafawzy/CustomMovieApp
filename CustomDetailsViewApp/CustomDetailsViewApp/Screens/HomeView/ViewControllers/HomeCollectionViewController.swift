//
//  HomeCollectionViewController.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "movie"

class HomeCollectionViewController: UICollectionViewController {

    var configurator = HomeConfiguratorImplementation()
    var presenter: HomePresenter!
    var  networkIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        configurator.configure(homeCollectionViewController: self)
        presenter.viewMovies(data: [:], headers: [:])
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}
