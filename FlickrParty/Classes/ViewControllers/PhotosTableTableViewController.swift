//
//  PhotosTableTableViewController.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/11/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

class PhotosTableTableViewController: UITableViewController {
    
    static let cellIdentifier = "PhotoCellIdentifier"
    
    var photosHeights: Array<CGFloat?> = Array<CGFloat?>()
    
    var photosItems = Array<PhotoItem>()  {
        didSet {
            for _ in self.photosHeights.count ..< self.photosItems.count {
                self.photosHeights.append(nil)
            }
            
            self.tableView.reloadData()
        }
    }
    
    weak var delegate: PhotoItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        self.registerTableViewCells()
        self.setupRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private Methods
    
    private func registerTableViewCells() {
        self.tableView.registerClass(
            PhotoTableViewCell.self,
            forCellReuseIdentifier: PhotosTableTableViewController.cellIdentifier
        )
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(
            self,
            action: #selector(PhotosTableTableViewController.refresh),
            forControlEvents: .ValueChanged
        )
        
        self.tableView.addSubview(refreshControl)
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

