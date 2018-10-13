//
//  Result.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}

enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
