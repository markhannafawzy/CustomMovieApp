//
//  BaseService.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class BaseService
{
    static var className: String { return "\(self)" }
    class var notificationName:Notification.Name  { return Notification.Name(className) }
    
    var queue:[String] = []
    
    
    public static let DataReceivedKey = "Data Received Successfully"
    public static let DataReceivedWithErrorKey = "Data received with  errors"
    public static let DataReceivedWithErrorResponseKey = "Data received with  error response"
    
    public static let ServiceName = "Service name"
    
    required init() {
        
    }
    
    
    func execute(data:Any?,tag:String,headers:[String:String]?) {
        
        let request = Request(tag: tag)
        
        if let _ = headers  {
            request.addHeaders(headers: headers!)
        }
        
        if let params = data as? [String:Any] {
            request.addParameters(parameters: params)
        }
        else if let params = data as? [Any] {
            request.url =  request.url +  encodeURL(parameters: params)
        }
        
        
        
        
        
        
        if AppConfigurations.appMode != .releaseProduction {
            //print("\n\(request.url) \nMethod: \(request.httpMethod) \nRepository: \(request.repository) \nTAG: \(tag)  \nParamters: \(data ?? [:])")
        }
        
        startRequest(request: request)
        
    }
    
    func encodedParamters(parameters:[String:Any])->[String:Any] {
        //Override this method to customize  paramters encoding
        let data = parameters
        return data
    }
    
    
    func encodeURL(parameters:[Any])->String {
        var queryString = ""
        
        for value in parameters {
            queryString += "\(value)/"
        }
        if queryString.count > 0
        {
            queryString.removeLast()
        }
        return queryString
    }
    
    
    func startRequest(request:Request){
        print(request)
        switch request.repository {
        case .offlineMockup:
            if let data = Bundle.readJson(fileName: request.url) {
                processReceivedData(responseData: data, requestId: request.tag)
            }
        default:
            let appDelegate =  UIApplication.shared.delegate as? AppDelegate
            
            if appDelegate?.internetReachable() == true {
                HttpManager.execute(request: request, encoding: request.encoding, successClosure: {responseData in
                    
                    self.processReceivedData(responseData: responseData, requestId: request.tag)
                    
                }) { error,errorResponse  in
                    //TODO:- General errors goes here
                    
                    
                    switch error.code {
                        
                    case 500:
                        let error500 = NetworkError(code: 0, message:"error 500")
                        self.requestDidFail(error: error500, errorResponse: nil, tag:request.tag)
                        
                    default:
                        self.requestDidFail(error: error,errorResponse: errorResponse, tag:request.tag)
                        break
                    }
                    
                }
            }
            else {
                //
                let error = NetworkError( code: 0, message:"no internet access")
                self.requestDidFail(error: error,errorResponse:nil, tag:request.tag)
            }
        }
    }
    
    func processReceivedData(responseData: Any, requestId: String){
        assertionFailure("You should override this method")
    }
    
    
    
    //MARK:- Sucess
    func requestDidSucess(responseData: Any, requestId: String){
        sendDataReceivedNotification(responseData: responseData, tag: requestId)
    }
    
    
    
    //MARK:- Do any logic related to failure case plus at end send notification
    func requestDidFail(error: NetworkError,errorResponse:Dictionary<String,Any>?,tag: String){
        sendErrorNotification(error: error,errorResponse: errorResponse, tag: tag)
    }
    
    
    
    //MARK:- Send notifications
    func sendDataReceivedNotification(responseData:Any, tag: String){
        
        let userInfo = [BaseService.DataReceivedKey: responseData, BaseService.ServiceName: tag] as [String : Any]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: tag), object: self, userInfo: userInfo)
    }
    
    func sendErrorNotification(error:NetworkError,errorResponse:Dictionary<String,Any>?,tag:String){
        let userInfo = [BaseService.DataReceivedWithErrorKey:error,
                        BaseService.DataReceivedWithErrorResponseKey:errorResponse,BaseService.ServiceName: tag] as [String : Any]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: tag), object: self, userInfo: userInfo)
    }
    
    
    
    //MARK:- Registr and unregistr  notification
    func addObserver(notificationName:String, callBack: Selector){
        NotificationCenter.default.addObserver(self, selector: callBack, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
    
    func removeObserver(notificationName:String){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
    
    
    
    //MARK:- Selectors that get called on notifications received
    func didReceiveNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            
            if let _ = userInfo[BaseService.DataReceivedKey] {
                requestDidSucess(responseData: userInfo[BaseService.DataReceivedKey]! as Any, requestId: notification.name.rawValue)
            }
            else {
                requestDidFail(error: userInfo[BaseService.DataReceivedWithErrorKey] as! NetworkError, errorResponse: userInfo[BaseService.DataReceivedWithErrorResponseKey] as? Dictionary<String,Any>, tag: notification.name.rawValue)
            }
        }
    }
}
