//
//  HomeResponse.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import ObjectMapper
class HomeResponse : Mappable{
    
    var page: Int!
    var numberOfResults: Int!
    var numberOfPages: Int!
    var movies: [Movie]!
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        page <- map["page"]
        numberOfResults <- map["total_results"]
        numberOfPages <- map["total_pages"]
        movies <- map["results"]
        
    }
    
    
}
