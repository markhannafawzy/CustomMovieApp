//
//  Cache.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

class Cache
{
    lazy var queue:NSMutableDictionary = [:]
    
    
    
    //MARK:- Add to queue
    func add(tag:String, serviceClassName:String, userData:Any, response: Any, status: RequestStatus,requestHeader:[String:String]) {
        let requestCacheItem = RequestCacheItem(serviceClassName:serviceClassName, status: status)
        requestCacheItem.userData = userData
        requestCacheItem.requestHeaders = requestHeader
        requestCacheItem.response = response
        requestCacheItem.requestHeaders = requestHeader
        
        queue.setObject(requestCacheItem, forKey: tag as NSCopying)
    }
    
    func add(tag: String, serviceClassName:String, userData: Any,requestHeader:[String:String]){
        let requestCacheItem = RequestCacheItem(serviceClassName:serviceClassName, status: .onProgress)
        requestCacheItem.userData = userData
        requestCacheItem.requestHeaders = requestHeader
        queue.setObject(requestCacheItem, forKey: tag as NSCopying)
    }
    
    
    //MARK:- Retrieve item
    func itemWithTag(tag:String)->RequestCacheItem?{
        return queue.value(forKey: tag) as? RequestCacheItem
    }
    
    
    
    //MARK:- Retrieve all items with tag containing string
    func allItemsWithTagPrefix(prefix:String)->[(tag:String, item:RequestCacheItem)] {
        var items:[(tag:String, item:RequestCacheItem)] = []
        for (tag, item) in queue {
            if (tag as! String).contains(prefix) {
                items.append((tag as! String, item: item as! RequestCacheItem))
            }
        }
        
        items.sort { $0.1.date! < $1.1.date! }
        
        return items
    }
    
    func mostEarlierCachedItemTagWithPrefix(prefix:String)->String {
        return allItemsWithTagPrefix(prefix: prefix).first?.tag ?? ""
    }
    
    
    //MARK:- update existing request data
    func updateItemResponse(tag:String, response:Any) {
        let cacheItem = itemWithTag(tag: tag)
        
        if cacheItem?.response == nil {
            cacheItem?.date = Date()
            cacheItem?.response = response
        }
    }
    
    func updateStatus(tag:String, status: RequestStatus){
        if let cacheItem = itemWithTag(tag: tag){
            cacheItem.status = status
        }
    }
    
    
    
    //MARK:- Remove cached request data , clear all cached requests data
    func removeItem(tag: String) {
        queue.removeObject(forKey: tag)
    }
    
    func  clear() {
        queue.removeAllObjects()
    }
    
    func allTags()-> [String] {
        if let _ = queue.allKeys as? [String] {
            return queue.allKeys as! [String]
        }
        return []
    }
    
    func allItems()-> [RequestCacheItem] {
        if let _ = queue.allValues as? [RequestCacheItem] {
            return queue.allValues as! [RequestCacheItem]
        }
        return []
    }
    
    func isEmpty()->Bool {
        return queue.allKeys.isEmpty
    }
    
    
    
    func thereArePendingItems()->Bool {
        let pendingCount = allItems().filter { $0.status == .pending }
        return pendingCount.count > 0
    }
    
}
