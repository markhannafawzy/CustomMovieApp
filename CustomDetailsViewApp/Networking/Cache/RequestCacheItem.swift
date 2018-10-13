//
//  RequestCacheItem.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

enum RequestStatus {
    case onProgress
    case success
    case pending
    case fail
}


class RequestCacheItem
{
    
    var requestHeaders:[String:String]?
    var userData: Any?
    var response: Any?
    var serviceClassName:String
    var date:Date?
    var status: RequestStatus
    
    
    
    init(serviceClassName:String,status: RequestStatus) {
        self.status = status
        self.serviceClassName = serviceClassName
    }
}
