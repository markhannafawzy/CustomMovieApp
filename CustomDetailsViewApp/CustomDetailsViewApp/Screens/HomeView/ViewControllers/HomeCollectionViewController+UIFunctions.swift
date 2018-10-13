//
//  HomeCollectionViewController+UIFunctions.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
extension HomeCollectionViewController{
    func  ShowloadingIndicator ()
    {
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    //Function Hansdle hide loading indicator
    func  hideloadingIndicator ()
    {
        networkIndicator.stopAnimating()
        
    }
    //Function Hansdle show error popup
    func ShowErrorPopup (errorMessage : String)
    {
        let Alert = UIAlertController(title: "Network Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(Alert, animated: true, completion: nil)
    }
    
}
