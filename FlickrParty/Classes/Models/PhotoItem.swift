//
//  PhotoItem.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/13/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import Foundation

class PhotoItem {
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
    
    init (photoID:String, farm:Int, server:String, secret:String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func downloadURL(size: String = "") -> NSURL {
        let sizeString = (size != "") ? "_\(size)" : ""
        
        return NSURL(string: "https://farm\(self.farm).staticflickr.com/\(self.server)/\(self.photoID)_\(self.secret)\(sizeString).jpg")!
    }
}