//
//  HomeService.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
class HomeService: BaseService {
    
    enum ErroCode:Int
    {
        case error = 0
        case sucess = 1
    }
    override func processReceivedData(responseData: Any, requestId: String)
    {
        
        if let data = responseData as? [String:Any]
        {
            
            requestDidSucess(responseData: responseData, requestId: requestId)
            
        }
        else
        {
            let error = NetworkError( code: 0, message: "Something went wrong")
            requestDidFail(error: error, errorResponse: nil, tag: "requestId")
        }
        
    }
    
}
