//
//  HttpManager.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Alamofire


typealias SuccessClosure = (Any)->Void
typealias FailureClosure = (NetworkError,Dictionary<String, Any>?)->Void

class HttpManager
{
    
    //MARK:- execute request with url
    class func execute(request:Request, encoding: ParameterEncoding = URLEncoding.default, successClosure:@escaping SuccessClosure, failureClosure:@escaping FailureClosure) {
        
        
        Alamofire.request(request.url, method: HTTPMethod(rawValue:request.httpMethod)!, parameters: request.parameters, encoding: encoding, headers: request.headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                
                if AppConfigurations.appMode == .debug {
                    print(response.debugDescription)
                }
                
                switch response.result {
                case .success:
                    successClosure(response.result.value as Any)
                case .failure(let error):
                    let errorResponseString = String(data: response.data!, encoding: String.Encoding.utf8) ?? ""
                    failureClosure(NetworkError(code: response.response?.statusCode ?? 0, message: error.localizedDescription),errorResponseString.toDictionary())
                }
        }
        
    }
}
