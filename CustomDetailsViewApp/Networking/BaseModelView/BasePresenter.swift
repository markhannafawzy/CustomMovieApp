//
//  BasePresenter.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
class BasePresenter : NSObject
{
    
    lazy var cache = Cache()
    
    
    
    
    
    //MARK:- Intializer
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(connectionDidBecomeDown),
                                               name: Notification.Name.notReachable,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(connectionDidBecomeUp),
                                               name: Notification.Name.reachable,
                                               object: nil)
        
    }
    
    
    @objc func connectionDidBecomeDown(){
        //TODO:- pause execution here and tell the controller that Internet is down
        
        //        printLog(tag: .info, data: "Execution paused")
        
        pause()
        
        let tag =  cache.allTags().first ?? ""
        
        let error = NetworkError( code: 0, message: "cannot cach request")
        
        let userInfo = [BaseService.DataReceivedWithErrorKey:error, BaseService.ServiceName: tag] as [String : Any]
        
        let notification = Notification(name: Notification.Name.notReachable, userInfo: userInfo)
        
        errorDidReceived(notification: notification as NSNotification)
    }
    
    
    @objc func connectionDidBecomeUp(){
        //TODO:- resume and  execute pending services here and tell the controller to show loading if needed
        
        if cache.thereArePendingItems() {
            let notification = Notification(name: Notification.Name.reachable)
            dataDidReceived(notification: notification as NSNotification)
        }
        
        resume()
    }
    
    
    
    
    
    //MARK:- Pause/Resume excution
    func pause() {
        removeAllItemsNotification()
    }
    
    func resume() {
        for tag in cache.allTags() {
            let item = self.cache.itemWithTag(tag: tag)
            
            if let serviceName = item?.serviceClassName {
                if let serviceClass = NSClassFromString("\(Bundle.main.targetName!).\(serviceName)")  as? BaseService.Type {
                    let service = serviceClass.init()
                    let params = item?.userData as? [String:Any] ?? [:]
                    let headers = item?.requestHeaders ?? [:]
                    executeService(service: service, userData: params, tag: tag, requestHeaders:headers)
                }
            }
            
        }
    }
    
    
    private func removeAllItemsNotification(){
        for tag in cache.allTags() {
            
            if cache.itemWithTag(tag: tag)?.status == .onProgress {
                cache.updateStatus(tag: tag, status: .pending)
            }
            removeObserver(notificationName: tag)
        }
    }
    
    
    //MARK:-
    func  executeService(service: BaseService,userData: Any, tag: String,requestHeaders:[String:String]) {
        let cacheItem = cache.itemWithTag(tag: tag)
        
        if cacheItem != nil &&  cacheItem?.status == .success  && cacheItem?.response != nil {
            addObserver(notificationName: tag, callBack: #selector(didReceiveNotification))
            service.requestDidSucess(responseData: cacheItem!.response, requestId: tag)
        }
        else {
            serviceWillStart(service: service, userData: userData, tag:tag, requestHeader: requestHeaders)
            service.execute(data: userData, tag: tag, headers: requestHeaders)
        }
    }
    
    
    func executeService<T: BaseService>(service: T, userData: Any,requestHeaders:[String:String]) {
        executeService(service: service, userData: userData, tag: T.className, requestHeaders: requestHeaders)
    }
    
    
    //MARK:-
    func serviceWillStart(service:BaseService, userData:Any, tag: String,requestHeader:[String:String]) {
        let serviceClassName = "\(type(of: service))"
        cache.add(tag: tag,serviceClassName:serviceClassName ,userData: userData,requestHeader:requestHeader)
        addObserver(notificationName: tag, callBack: #selector(didReceiveNotification))
    }
    
    
    
    //MARK:- Registr and unregistr  notification
    private func addObserver(notificationName:String, callBack: Selector){
        NotificationCenter.default.addObserver(self, selector: callBack, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
    
    private func removeObserver(notificationName:String){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
    
    
    
    //MARK:- Selectors that get called on notifications received
    @objc
    func didReceiveNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            if let _ = userInfo[BaseService.DataReceivedKey] {
                dataDidReceived(notification: notification)
            }
            else {
                errorDidReceived(notification: notification)
            }
        }
    }
    
    func dataDidReceived(notification: NSNotification) {
        serviceDidFinish(tag: notification.name.rawValue, responseData: notification.userInfo?[BaseService.DataReceivedKey] ?? [:],  requestStatus: .success)
    }
    
    func errorDidReceived(notification: NSNotification){
        serviceDidFinish(tag: notification.name.rawValue, responseData: notification.userInfo?[BaseService.DataReceivedWithErrorKey] ?? "", requestStatus: .fail)
    }
    
    
    func serviceDidFinish(tag:String, responseData: Any, requestStatus: RequestStatus){
        
        cache.updateItemResponse(tag: tag, response: responseData)
        cache.updateStatus(tag: tag, status: requestStatus)
        
        if shouldRemoveRequestFromCache(tag: tag) {
            cache.removeItem(tag: tag)
            removeObserver(notificationName: tag)
        }
    }
    
    
    
    //MARk:- Model must decide if request should be removed from cache
    func shouldRemoveRequestFromCache(tag:String)-> Bool {
        if let item = cache.itemWithTag(tag: tag) {
            switch(item.status) {
            case .pending, .onProgress: return false
            case .success, .fail: return true
            }
        }
        return true
    }
    
    
    
    //MARK:- Are there any requests execution in progress or pending
    func didFinishAllRequests()->Bool{
        for tag in cache.allTags() {
            if let item = cache.itemWithTag(tag: tag) {
                switch(item.status){
                case .pending, .onProgress:
                    return false
                case .success, .fail:
                    continue
                }
            }
        }
        return true
    }
    
    
    
    //MARK:- Release resources
    deinit {
        NotificationCenter.default.removeObserver(self)
        cache.clear()
    }
    
}
