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
        return 10
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
            PhotosTableTableViewController.cellIdentifier,
            forIndexPath: indexPath
        ) as! PhotoTableViewCell
        
        cell.selectionStyle = .None
        
        let url = NSURL(string: (indexPath.section % 2 == 0) ? "https://farm8.staticflickr.com/7452/27587513596_f3d00cca30.jpg" : "https://farm8.staticflickr.com/7128/27519723042_51d7e1c7a2.jpg")!
        
        cell.photoImageView?.sd_setImageWithURL(url, placeholderImage: nil, options: .RefreshCached, completed: { (image, error, cacheTyp, url) in
            
            let oldValue = self.photosHeights[indexPath.section]
            
            let newValue = image.size.height
            
            self.photosHeights[indexPath.section] = newValue
            cell.photoImageView?.image = image
            
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