//
//  NetworkError.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

struct NetworkError: Error
{
    
    var message:String
    var code:Int
    
    
    
    //MARK:- Intializer
    init(code: Int, message: String) {
        self.message = message
        self.code = code
    }
    
    init(error: Error) {
        message = error.localizedDescription
        code = 0
    }
}
