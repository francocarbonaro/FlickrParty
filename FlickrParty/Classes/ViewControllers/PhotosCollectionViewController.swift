//
//  PhotosCollectionViewController.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/12/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    var photosHeights: Array<CGFloat?> = Array<CGFloat?>(count:10, repeatedValue: nil)
    
    static let cellIdentifier = "PhotoCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()

        self.collectionView!.registerClass(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewController.cellIdentifier
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotosCollectionViewController.cellIdentifier,
                                                                         forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let url = NSURL(string: (indexPath.row % 2 == 0) ? "https://farm8.staticflickr.com/7452/27587513596_f3d00cca30_s.jpg" : "https://farm8.staticflickr.com/7128/27519723042_51d7e1c7a2_s.jpg")!
        
        cell.photoImageView?.sd_setImageWithURL(url, placeholderImage: nil, options: .RefreshCached, completed: { (image, error, cacheTyp, url) in
            
            cell.photoImageView?.image = image
        })
    
        return cell
    }
}
