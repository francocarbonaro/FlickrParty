//
//  PhotosCollectionViewControllerDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension PhotosCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard self.photosItems.count > indexPath.row else {
            return
        }
        
        let photoItem = self.photosItems[indexPath.row]
        
        let vc = PhotoDetailViewController(photoItem: photoItem)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}