//
//  HomeSeviceConfiguration.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Alamofire

class HomeServiceConfiguration : EndPointConfiguration {
    
    override var path: String { return "discover/movie?api_key=bd97fe04de1096c3c59c20c445de2b05"}
    override var httpMethod: HTTPMethod { return .get}
    override var encoding: ParameterEncoding { return URLEncoding.default }
}
