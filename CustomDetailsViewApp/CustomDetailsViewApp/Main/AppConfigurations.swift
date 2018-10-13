//
//  AppConfigurations.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

enum Mode:String {
    case debug, releaseDebug,  releaseProduction
}

enum Repository:String {
    case  dev, demo, live, onlineMockup, offlineMockup
}


struct AppConfigurations
{
    
    static var appMode: Mode { return .releaseProduction }
    
    static var forceProduction: Bool { return appMode == .releaseProduction }
    
    
    static var repository:Repository {
        
        let repository:Repository = .live
        
        return forceProduction ? .live : repository
    }
    
    
    static var liveUrl: String { return "http://api.themoviedb.org/3/" }
    
    static var demoUrl: String { return "http://api.themoviedb.org/3/" }
    
    static var devUrl: String { return "http://api.themoviedb.org/3/" }
    
    static var onlineMockupUrl: String { return "http://api.themoviedb.org/3/" }
    
    static var generalImageUrl: String {return "http://image.tmdb.org/t/p/w185/"}
    
}
