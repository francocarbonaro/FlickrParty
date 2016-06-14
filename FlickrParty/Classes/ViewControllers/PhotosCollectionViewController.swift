//
//  PhotosCollectionViewController.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/12/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    static let cellIdentifier = "PhotoCellIdentifier"
    
    var photosItems = Array<PhotoItem>() {
        didSet {
            self.collectionView!.reloadData()
        }
    }
    
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
}
