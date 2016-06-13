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
    
    var photosHeights: Array<CGFloat?> = Array<CGFloat?>(count:10, repeatedValue: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        self.registerTableViewCells()
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
}

