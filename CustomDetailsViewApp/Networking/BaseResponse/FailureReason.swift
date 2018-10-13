//
//  FailureReason.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import ObjectMapper


class FailureReason: Mappable {
    
    //MARK:- Properties
    var id = 0
    var message:String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    //MARK:- Map
    func mapping(map: Map) {
        id <- map["fail_reason_id"]
        message <- map["message"]
    }
}
