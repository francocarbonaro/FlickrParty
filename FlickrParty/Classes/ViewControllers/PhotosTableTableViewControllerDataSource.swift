//
//  PhotosTableTableViewControllerDataSource.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/11/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension PhotosTableTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photosItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
            PhotosTableTableViewController.cellIdentifier,
            forIndexPath: indexPath
        ) as! PhotoTableViewCell
        
        cell.selectionStyle = .None

        let photoItem = self.photosItems[indexPath.row]
        
        cell.photoImageView?.sd_setImageWithURL(photoItem.downloadURL(), placeholderImage: nil, options: .RefreshCached, completed: { (image, error, cacheTyp, url) in
            
            cell.photoImageView?.image = image
            
            guard self.photosItems.count > indexPath.row else {
                return
            }
            
            let oldValue = self.photosHeights[indexPath.row]
            
            let newValue = image.size.height
            
            self.photosHeights[indexPath.row] = newValue            
            
            if self.tableView.visibleCells.contains(cell) {
                guard let value = oldValue else {
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                    return
                }
    
                if value != newValue {
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                    return
                }
            }
        })
       
        return cell
    }
}