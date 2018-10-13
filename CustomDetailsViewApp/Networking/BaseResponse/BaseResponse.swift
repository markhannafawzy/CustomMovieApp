//
//  BaseResponse.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import ObjectMapper


class BaseResponse: Mappable
{
    
    
    enum ResultCode:Int {
        case failure = 0
        case sucess = 1
    }
    
    
    //MARK:- Properties
    var status:Bool?
    var message:String?
    var object:Any?
    
    
    //MARK:- Intializer
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    //MARK:- Map
    func mapping(map: Map) {
        status <- map ["status"]
        message <- map ["message"]
        object <- map ["object"]
    }
}
