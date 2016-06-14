//
//  PhotosCollectionViewControllerDataSource.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension PhotosCollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotosCollectionViewController.cellIdentifier,
                                                                         forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let photoItem = self.photosItems[indexPath.row]
        
        cell.photoImageView?.sd_setImageWithURL(photoItem.downloadURL("s"), placeholderImage: nil, options: .RefreshCached, completed: { (image, error, cacheTyp, url) in
            
            cell.photoImageView?.image = image
        })
        
        return cell
    }
}
