//
//  EndPointConfiguration.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import Alamofire

class EndPointConfiguration
{
    
    enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
    }
    
    
    
    //override if required
    var requestrRepository:Repository {return .live}
    var httpMethod: HTTPMethod { return .post}
    var encoding: ParameterEncoding { return URLEncoding.default }
    var path:String {return ""}
    var liveUrl: String { return AppConfigurations.liveUrl }
    var demoUrl: String { return AppConfigurations.demoUrl }
    var devUrl: String { return AppConfigurations.devUrl }
    var onlineMockupUrl: String { return AppConfigurations.onlineMockupUrl }
    
    
    //Final
    final var repository: Repository { return AppConfigurations.forceProduction ? AppConfigurations.repository : requestrRepository }
    final var url: String { return "\(initURL())"}
    
    
    
    
    
    
    
    required init() {
    }
    
    
    
    private func initURL()->String {
        switch repository {
        case .live:
            return  liveUrl + path
        case .demo:
            return  demoUrl + path
        case .dev:
            return  devUrl + path
        case .onlineMockup:
            return  onlineMockupUrl + path
        case .offlineMockup:
            return path
        }
    }
    
}
