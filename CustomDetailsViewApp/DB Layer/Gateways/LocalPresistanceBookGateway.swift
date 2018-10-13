//
//  LocalPresistanceMovieGateway.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistenceMoviesGateway {
    
    func fetchMovies(completionHandler: @escaping (Result<[Movie]>) -> Void)
    func add(parameters: Movie, completionHandler: @escaping (Result<Movie>) -> Void)
    func delete(Movie: Movie, completionHandler: @escaping (Result<Void>) -> Void)
    func reset(completionHandler: @escaping (Result<Void>) -> Void)
    func save(movies: [Movie] , completionHandler: @escaping (Result<[Movie]>) -> Void)
    func add(movie: Movie)
}

class CoreDataMoviesGateway: LocalPersistenceMoviesGateway {
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    // MARK: - MoviesGateway
    
    func fetchMovies(completionHandler: @escaping (Result<[Movie]>) -> Void) {
        if let coreDataMovies = try? viewContext.allEntities(withType: CoreDataMovie.self) {
            let Movies = coreDataMovies.map { $0.movie }
            completionHandler(.success(Movies))
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving Movies the data base")))
        }
    }
    
    func add(parameters: Movie, completionHandler: @escaping (Result<Movie>) -> Void) {
        guard let coreDataMovie = viewContext.addEntity(withType: CoreDataMovie.self) else {
            completionHandler(.failure(CoreError(message: "Failed adding the Movie in the data base")))
            return
        }
        
        coreDataMovie.populate(with: parameters)
        
        do {
            try viewContext.save()
            completionHandler(.success(coreDataMovie.movie))
        } catch {
            viewContext.delete(coreDataMovie)
            completionHandler(.failure(CoreError(message: "Failed saving the context")))
        }
    }
    
    func delete(Movie: Movie, completionHandler: @escaping (Result<Void>) -> Void) {
        let predicate = NSPredicate(format: "id==%@", Movie.id)
        
        if let coreDataMovies = try? viewContext.allEntities(withType: CoreDataMovie.self, predicate: predicate),
            let coreDataMovie = coreDataMovies.first {
            viewContext.delete(coreDataMovie)
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving Movies the data base")))
            return
        }
        
        do {
            try viewContext.save()
            completionHandler(.success(()))
        } catch {
            completionHandler(.failure(CoreError(message: "Failed saving the context")))
        }
        
    }
    
    // MARK: - LocalPersistenceMoviesGateway
    
    func save(movies: [Movie] , completionHandler: @escaping (Result<[Movie]>) -> Void) {
        // Save Movies to core data. Depending on your specific need this might need to be turned into some kind of merge mechanism.
        for movie in movies {
            guard let coreDataMovie = viewContext.addEntity(withType: CoreDataMovie.self) else {
                completionHandler(.failure(CoreError(message: "Failed adding the Movie in the data base")))
                try? viewContext.deleteAllEntities(withType: CoreDataMovie.self)
                return
            }
            coreDataMovie.populate(with: movie)
        }
        do {
            try viewContext.save()
            completionHandler(.success(movies))
        } catch {
            
        }
    }
    
    func add(movie: Movie) {
        // Add Movie. Usually you could call this after the entity was successfully added on the API side or you could use the save method.
    }
    
    func reset(completionHandler: @escaping (Result<Void>) -> Void) {
        do {
            try viewContext.deleteAllEntities(withType: CoreDataMovie.self)
            completionHandler(.success(()))
        } catch {
            completionHandler(.failure(CoreError(message: "Failed deleting all Movies from the data base")))
        }
    }
}
