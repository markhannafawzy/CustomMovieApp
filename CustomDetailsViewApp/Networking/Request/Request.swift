//
//  Request.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import Alamofire

//MARK:- Request
class Request
{
    var id: String
    var tag: String
    
    var httpMethod: String = ""
    var url: String = ""
    var repository: Repository = AppConfigurations.repository
    var encoding: ParameterEncoding = URLEncoding.default
    
    
    private  var httpParameters:[String:Any]?
    private  var httpHeaders:[String:String]?
    
    var headers:[String:String]? { return httpHeaders }
    var parameters:[String:Any]? { return httpParameters}
    
    
    
    
    //MARK:- Intializer
    init(tag:String) {
        
        id = tag
        self.tag = tag
        
        if let configurationClass = NSClassFromString("\(Bundle.main.targetName!).\(tag)Configuration")  as? EndPointConfiguration.Type {
            
            let configuration =  configurationClass.init()
            
            httpMethod = configuration.httpMethod.rawValue
            
            url = configuration.url
            
            repository = configuration.repository
            
            encoding = configuration.encoding
            
        }
    }
    
    convenience init(tag:String, userData: [String:Any]) {
        self.init(tag: tag)
        self.httpParameters += userData
    }
    
    
    
    
    //MARK:- Add http paramters
    func setParamters(parameter:Any, forParameterName:String){
        if let _ = httpParameters {
            httpParameters?[forParameterName] = parameter
        }
        else {
            httpParameters = [:]
            httpParameters?[forParameterName] = parameter
        }
    }
    
    func addParameters(parameters: [String:Any]?){
        httpParameters += parameters
    }
    
    
    
    //MARK:- Add http paramters
    func setHeaders(value:String, name:String){
        if let _ = httpHeaders {
            httpHeaders?[name] = value
        }
        else {
            httpHeaders = [:]
            httpHeaders?[name] = value
        }
    }
    
    func addHeaders(headers: [String:String]){
        httpHeaders += headers
    }
}
