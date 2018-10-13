//
//  Notification.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

extension Notification
{
    
    
    init(name:String) {
        let notificationName = Notification.Name(rawValue: name)
        self =  Notification(name: notificationName)
    }
    
}


extension NSNotification.Name
{
    
    static let reachable = Notification.Name(rawValue:"Reachable")
    static let notReachable = Notification.Name(rawValue:"NotReachable")
    
}
