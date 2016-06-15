//
//  PhotoDetailViewController.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/14/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

private let kPhotoImageViewTopPortrait: CGFloat = 64

private let kPhotoImageViewTopLandscape: CGFloat = 32

class PhotoDetailViewController: UIViewController {

    var photoItem: PhotoItem
    
    var photoImageView: UIImageView?
    
    var activityIndicatorView: UIActivityIndicatorView?
    
    var photoImageViewTopConstraint: NSLayoutConstraint?
    
    init(photoItem: PhotoItem) {
        self.photoItem = photoItem
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupPhotoImageView()
        self.setupActivityIndicatorView()
        self.setupShareButton()
        
        self.photoImageView?.sd_setImageWithURL(self.photoItem.downloadURL(), completed: { (image, error, cacheType, url) in
            
            self.photoImageView?.image = image
            self.activityIndicatorView?.stopAnimating()
            self.navigationItem.rightBarButtonItem?.enabled = true
        })
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
        
        if let topConstraint = self.photoImageViewTopConstraint {
            topConstraint.constant = (isPortrait) ? kPhotoImageViewTopPortrait : kPhotoImageViewTopLandscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    private func setupPhotoImageView() {
        guard self.photoImageView == nil else {
            return
        }
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.whiteColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
        
        self.photoImageView = imageView
        self.view.addSubview(imageView)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.photoImageViewTopConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Top,
            multiplier: 1.0,
            constant: (isPortrait) ? kPhotoImageViewTopPortrait : kPhotoImageViewTopLandscape
        )
        
        self.view.addConstraint(self.photoImageViewTopConstraint!)

        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.updateViewConstraints()
    }
    
    private func setupActivityIndicatorView() {
        guard self.activityIndicatorView == nil else {
            return
        }
        
        let aiView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        aiView.translatesAutoresizingMaskIntoConstraints = false
        aiView.hidesWhenStopped = true
        aiView.startAnimating()
        
        self.activityIndicatorView = aiView
        self.view.addSubview(aiView)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: aiView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: aiView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.updateViewConstraints()
    }
    
    private func setupShareButton() {
        let shareButton: UIBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Action,
            target: self,
            action: #selector(PhotoDetailViewController.shareButtonTouched)
        )
        
        shareButton.enabled = false
        
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    func shareButtonTouched() {
        guard let image = self.photoImageView?.image else {
            return
        }
        
        let activityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        self.navigationController?.presentViewController(activityViewController, animated: true) {
            
        }
    }
    
}
