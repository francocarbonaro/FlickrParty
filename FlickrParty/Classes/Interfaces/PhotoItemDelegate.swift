//
//  PhotoItemDelegate.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

protocol PhotoItemDelegate: class {
    
    func getNewPhotos()
    
    func getOlderPhotos()
}