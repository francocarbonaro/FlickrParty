//
//  PhotosTableTableViewController+PhotosLayoutDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension PhotosTableTableViewController: PhotosLayoutDelegate {

    func addNewPhotos(newPhotosItems: Array<PhotoItem>) {
        guard newPhotosItems.count > 0 else {
            return
        }

        var indexPaths = Array<NSIndexPath>()
        var i = 0
        
        self.tableView.beginUpdates()
        
        for photoItem in newPhotosItems {
            
            self.photosItems.insert(photoItem, atIndex: i)
            
            indexPaths.append(NSIndexPath(forRow: i, inSection: 0))
            
            i += 1
        }
        
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        self.tableView.endUpdates()
    }
}
