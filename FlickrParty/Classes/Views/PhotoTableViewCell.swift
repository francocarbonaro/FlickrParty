//
//  PhotoTableViewCell.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/11/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    var photoImageView: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupPhotoImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private Methods
    
    private func setupPhotoImageView() {
        self.photoImageView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        self.photoImageView?.backgroundColor = UIColor.grayColor()
        self.photoImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.photoImageView!)

        self.addConstraint(NSLayoutConstraint(
            item: self.photoImageView!,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.addConstraint(NSLayoutConstraint(
            item: self.photoImageView!,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.addConstraint(NSLayoutConstraint(
            item: self.photoImageView!,
            attribute: .Height,
            relatedBy: .LessThanOrEqual,
            toItem: self.photoImageView!,
            attribute: .Height,
            multiplier: 1.0,
            constant: 320
            )
        )
        
        self.setNeedsUpdateConstraints()
    }
    
    // MARK: - Public Methods
    
    func setPhotoURL(url: NSURL) {
        
    }
}
