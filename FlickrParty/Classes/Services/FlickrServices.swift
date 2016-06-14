//
//  FlickrServices.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/13/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

private let apiKey = "2ee33e4405b1db2798c530478c93378c"

private let defaultSearchTag = "party"

class FlickrServices: NSObject {
    
    private func searchPhotosUrl() -> NSURL {
        return NSURL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(defaultSearchTag)&format=json&nojsoncallback=1&api_sig=7d87b1efad2d398d174482a2d6e5f541")!
    }
    
    func searchPhotos(completionBlock: (results: Array<PhotoItem>?, error: NSError?) -> Void) {
        let url = self.searchPhotosUrl()

        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            guard let result = data where error == nil else {
                completionBlock(results: nil, error: error)
                return
            }
            
            let json = JSON(data: result)
            let jsonPhotos = json["photos"]["photo"]
            var photosArray = Array<PhotoItem>()
            
            for (_, jsonPhotoItem) in jsonPhotos {
                let photoID = jsonPhotoItem["id"].stringValue
                let farm = jsonPhotoItem["farm"].intValue
                let server = jsonPhotoItem["server"].stringValue
                let secret = jsonPhotoItem["secret"].stringValue
                
                guard photoID != "" && farm != 0 && server != "" && secret != "" else {
                    continue
                }
                
                let photoItem = PhotoItem(
                    photoID: photoID,
                    farm: farm,
                    server: server,
                    secret: secret
                )
                
                photosArray.append(photoItem)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                completionBlock(results: photosArray, error: nil)
            }
        }
        
        task.resume()
    }
    
}
