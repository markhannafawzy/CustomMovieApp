//
//  HomeConfigurator.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

protocol HomeConfigurator {
    func configure(homeCollectionViewController: HomeCollectionViewController)
}

class HomeConfiguratorImplementation: HomeConfigurator {
    
    func configure(homeCollectionViewController: HomeCollectionViewController) {

        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataMoviesGateway = CoreDataMoviesGateway(viewContext: viewContext)
        let homeService = HomeService()
        
        let presenter = HomePresenter(viewController: homeCollectionViewController,
                                      service: homeService,
                                      gateway: coreDataMoviesGateway)
        
        homeCollectionViewController.presenter = presenter
    }
}
