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
    
    weak var delegate: PhotoItemDelegate?
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.registerCollectionViewCells()
        
        self.setupRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private Methods
    
    private func registerCollectionViewCells() {
        self.collectionView!.registerClass(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewController.cellIdentifier
        )
    }

    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(PhotosTableTableViewController.refresh),
            forControlEvents: .ValueChanged
        )
        
        self.collectionView!.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }
    
    func refresh() {
        if let rc = self.refreshControl {
            rc.endRefreshing()
        }
        
        guard let del = self.delegate else {
            return
        }
        
        del.getNewPhotos()
    }

}
