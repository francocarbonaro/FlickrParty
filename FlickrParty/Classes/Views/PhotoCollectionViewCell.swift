//
//  PhotoCollectionViewCell.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/12/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupPhotoImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupPhotoImageView() {
        self.photoImageView = UIImageView(frame: CGRectMake(0, 0, 75, 75))
        self.photoImageView?.backgroundColor = UIColor.whiteColor()
        self.photoImageView?.contentMode = .ScaleAspectFit
        self.photoImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.photoImageView!)
    }
}

