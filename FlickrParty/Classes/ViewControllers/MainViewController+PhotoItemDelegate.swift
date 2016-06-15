//
//  MainViewController+PhotoItemDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

extension MainViewController: PhotoItemDelegate {

    func getNewPhotos() {
        let service = FlickrServices()
        
        service.searchPhotos { (results, error) in
            guard let allItems = results where error == nil else {
                return
            }
            
            var newPhotosItems = Array<PhotoItem>()
            var i = 0
            
            for photoItem in allItems {
                guard self.photosItems.indexOf({ $0.photoID == photoItem.photoID }) == nil else {
                    continue
                }
                
                newPhotosItems.append(photoItem)
                self.photosItems.insert(photoItem, atIndex: i)
                
                i += 1
            }
            
            self.photosTableViewController?.addNewPhotos(newPhotosItems)
            self.photosCollectionViewController?.addNewPhotos(newPhotosItems)
        }
    }
    
    func getOlderPhotos() {
        
    }
}
