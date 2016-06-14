//
//  PhotosCollectionViewControllerDelegateFlowLayout.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/13/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

private let kSectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 75, height: 75)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return kSectionInsets
    }
}
