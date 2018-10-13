//
//  Movie.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import ObjectMapper
class Movie: Mappable {
    
    var id: Int!
    var posterPath: String!
    var backdrop: String!
    var title: String!
    var releaseDate: String!
    var rating: Double!
    var overview: String!
    
    init(id: Int,
        posterPath: String,
        backdrop: String,
        title: String,
        releaseDate: String,
        rating: Double,
        overview: String) {
        self.id = id
        self.posterPath = posterPath
        self.backdrop = backdrop
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.overview = overview
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        posterPath <- map["poster_path"]
        backdrop <- map["backdrop_path"]
        title <- map["title"]
        releaseDate <- map["release_date"]
        rating <- map["vote_average"]
        overview <- map["overview"]
    }
}
