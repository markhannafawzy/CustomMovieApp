//
//  HomePresenter.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
class HomePresenter :BasePresenter{
    
    let homeCollectionViewController : HomeCollectionViewController
    let homeService : HomeService
    let localPersistenceMoviesGateway : CoreDataMoviesGateway
    
    var movies = [Movie]()
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    init(viewController: HomeCollectionViewController,
         service: HomeService,
         gateway: CoreDataMoviesGateway) {
        homeCollectionViewController = viewController
        homeService = service
        localPersistenceMoviesGateway = gateway
    }
    
    func viewMovies(data :[String:Any],headers:[String:String]) {
        executeService(service: homeService, userData: data, tag: HomeService.className, requestHeaders: headers)
        homeCollectionViewController.ShowloadingIndicator()
    }
    
    func configure(cell: MovieCell, forRow row: Int) {
        let movie = movies[row]
        
        cell.display(title: movie.title)
        cell.display(url: URL(string: AppConfigurations.generalImageUrl+movie.posterPath)!)
    }
    
    override func dataDidReceived(notification: NSNotification)
    {
        print("Done Presenter")
        //TODO: hide loading indicator
        homeCollectionViewController.hideloadingIndicator()
        switch notification.name {
        case HomeService.notificationName:
            // loginRouter.navigateToHomeView()
            print(notification.name)
        default:
            break
        }
        var responseData = notification.userInfo![BaseService.DataReceivedKey]
        if let data = responseData as? [String:Any]
        {
            let result =  HomeResponse(JSON: data)
            
            print("page: \(String(describing: result?.page))")
            print("numberOfPages : \(String(describing: result?.numberOfPages))")
            print("numberOfResults : \(String(describing: result?.numberOfResults))")
            print("movies : \(String(describing: result?.movies))")
            self.movies = (result?.movies)!
            resetDatabase()
            saveMovies(movies: movies)
            homeCollectionViewController.updateUI()
        }
        super.dataDidReceived(notification: notification)
    }
    
    func resetDatabase() {
        self.localPersistenceMoviesGateway.reset { (result) in
            switch result {
            case let .success():
                print("database successfuly empted")
            case let .failure(error):
                print(error)
            }
        }
    }
    func saveMovies(movies: [Movie]) {
        self.localPersistenceMoviesGateway.save(movies: movies) { (result) in
            switch result {
            case let .success(movies):
                print("movies saved successfuly")
                print(movies)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchMovies() {
        self.localPersistenceMoviesGateway.fetchMovies { (result) in
            switch result {
            case let .success(movies):
                self.movies = movies
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK:- Error received
    override func errorDidReceived(notification: NSNotification)
    {
        homeCollectionViewController.hideloadingIndicator()
        switch notification.name {
            
        case HomeService.notificationName:
            
            let error =  notification.userInfo?[BaseService.DataReceivedWithErrorResponseKey] as? Dictionary<String,Any>
            let errorString = error!["message"] as! String
            print("error is "+errorString);
            homeCollectionViewController.ShowErrorPopup(errorMessage: errorString)
            fetchMovies()
        default:
            break
            
        }
        
        super.errorDidReceived(notification: notification)
    }
    
}
