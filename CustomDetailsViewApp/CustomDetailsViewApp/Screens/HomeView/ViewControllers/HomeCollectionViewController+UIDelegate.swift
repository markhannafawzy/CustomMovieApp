//
//  HomeCollectionViewController+UIDelegate.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 9/15/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

extension HomeCollectionViewController
{
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MovieCell
        presenter.configure(cell: cell, forRow: indexPath.row)

        return cell
    }
    
    // MARK: UICollectionViewDelegate
 
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //return CGSize(width: 300, height: 100)
//        //let wid = self.collectionView!.frame.size.width
//        let width = UIScreen.main.bounds.width-5
//        let height = UIScreen.main.bounds.height/3
//        return CGSize(width: width, height:height)
//    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    func updateUI (){
        collectionView?.reloadData()
    }
    
}
