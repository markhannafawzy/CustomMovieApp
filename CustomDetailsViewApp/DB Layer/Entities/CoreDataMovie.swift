//
//  CoreDataMovie.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataMovie {
    var movie: Movie {
        return Movie(id: Int(id),
                    posterPath: posterPath ?? "",
                    backdrop: backdrop ?? "",
                    title: title ?? "",
                    releaseDate: releaseDate ?? "",
                    rating: Double(rating),
                    overview: overview ?? "")
    }
    
    func populate(with parameters: Movie) {
//        id = NSUUID().uuidString
        id = Int64(parameters.id)
        posterPath = parameters.posterPath
        backdrop = parameters.backdrop
        title = parameters.title
        releaseDate = parameters.releaseDate
        rating = parameters.rating
        overview = parameters.overview
    }
}
