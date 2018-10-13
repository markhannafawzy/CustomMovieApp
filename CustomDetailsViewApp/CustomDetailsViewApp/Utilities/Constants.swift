//
//  Constants.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

struct Constants {

    static let Email_regex_constant = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let Phone_number_regex_constant = "\\A[0-9]{11}\\z"
    
    //MARK: View Controllers IDs

    static let Details_View_controller_identifer = "DetailsViewController"
    
    //MARK: Storyboards IDs
    static let Main_storyboard_idenitifer = "main"
    private static let apiKey = "api_key"
    private static let apiKeyValue = "bd97fe04de1096c3c59c20c445de2b05"
    static let apiKeyValuePair = [apiKey : apiKeyValue]
}
