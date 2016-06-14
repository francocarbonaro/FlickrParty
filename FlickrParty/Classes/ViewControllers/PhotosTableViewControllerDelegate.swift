//
//  PhotosTableViewControllerDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/11/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension PhotosTableTableViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let height = self.photosHeights[indexPath.section] {
            return height
        }
        
        return 500
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard self.photosItems.count > indexPath.section else {
            return
        }
        
        let photoItem = self.photosItems[indexPath.section]
        
        let vc = PhotoDetailViewController(photoItem: photoItem)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}