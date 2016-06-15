//
//  PhotosLayoutDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

protocol PhotosLayoutDelegate: class {

    func addNewPhotos(newPhotosItems: Array<PhotoItem>)
    
    
    // to implement
    //func addOlderPhotos(newPhotosItems: Array<PhotoItem>)
}
