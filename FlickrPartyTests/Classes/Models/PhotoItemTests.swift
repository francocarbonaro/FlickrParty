//
//  PhotoItemTests.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/13/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import XCTest
@testable import FlickrParty

class PhotoItemTests: XCTestCase {
    
    var photoItem: PhotoItem?
    
    override func setUp() {
        super.setUp()
        
        self.photoItem = PhotoItem(
            photoID: "123213213",
            farm: 7000,
            server: "292929",
            secret: "3213123123"
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDownloadUrl() {
        let url = self.photoItem!.downloadURL()
        
        XCTAssertEqual(url.absoluteString, "https://farm7000.staticflickr.com/292929/123213213_3213123123.jpg")
    }
    
    func testDownloadUrlWithSize() {
        let url = self.photoItem!.downloadURL("u")
        
        XCTAssertEqual(url.absoluteString, "https://farm7000.staticflickr.com/292929/123213213_3213123123_u.jpg")
    }
}
