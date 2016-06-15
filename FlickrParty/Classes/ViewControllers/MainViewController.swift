//
//  MainViewController.swift
//  FlickrParty
//
//  Created by Franco Carbonaro on 6/11/16.
//  Copyright © 2016 FrancoCarbonaro. All rights reserved.
//

import UIKit

private let kSegmentedControlTopPortrait: CGFloat = 64

private let kSegmentedControlTopLandscape: CGFloat = 32

class MainViewController: UIViewController {
    
    var segmentedControl: UISegmentedControl?
    
    var containerView: UIView?
    
    var segmentedControlTopConstraint: NSLayoutConstraint?
    
    var photosTableViewController: PhotosTableTableViewController?
    
    var photosCollectionViewController: PhotosCollectionViewController?
    
    var photosItems = Array<PhotoItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Flickr Party"
        
        self.createSegmentedControlIfNecessary()
        
        self.setupContainerView()
        
        self.setupPhotosTableViewController()
        
        let services = FlickrServices()
        
        services.searchPhotos { (results, error) in
            guard let items = results else {
                return
            }
            
            self.photosItems += items
            self.photosTableViewController?.photosItems += items
            self.photosCollectionViewController?.photosItems += items
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
        
        if let scTopConstraint = self.segmentedControlTopConstraint {
            scTopConstraint.constant = (isPortrait) ? kSegmentedControlTopPortrait : kSegmentedControlTopLandscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    private func createSegmentedControlIfNecessary() {
        guard self.segmentedControl == nil else {
            return
        }
        
        let isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
        
        let sc = UISegmentedControl(items: ["Lista", "Galeria"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(
            self,
            action: #selector(MainViewController.segmentedControlValueChanged),
            forControlEvents: .ValueChanged
        )
        
        self.view.addSubview(sc)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: sc,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0
            )
        )
     
        self.view.addConstraint(NSLayoutConstraint(
            item: sc,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0
            )
        )

        self.segmentedControlTopConstraint = NSLayoutConstraint(
            item: sc,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Top,
            multiplier: 1.0,
            constant: (isPortrait) ? kSegmentedControlTopPortrait : kSegmentedControlTopLandscape
        )
        
        self.view.addConstraint(self.segmentedControlTopConstraint!)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: sc,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1.0,
            constant: 30
            )
        )
        
        self.view.updateConstraints()
        self.segmentedControl = sc
    }
    
    private func setupContainerView() {
        guard self.containerView == nil else {
            return
        }

        let view = UIView()
        view.backgroundColor = UIColor.blueColor()
        view.translatesAutoresizingMaskIntoConstraints = false

        self.containerView = view
        self.view.addSubview(view)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.segmentedControl!,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        self.view.updateConstraints()
    }
    
    private func setupChildViewController(vc: UIViewController) {
        guard let containerView = self.containerView else {
            return
        }
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChildViewController(vc)
        containerView.addSubview(vc.view)
        vc.didMoveToParentViewController(self)
    }
    
    private func removeChildViewController(vc: UIViewController?) {
        vc?.willMoveToParentViewController(nil)
        vc?.view.removeFromSuperview()
        vc?.removeFromParentViewController()
    }
    
    private func setupPhotosTableViewController() {
        guard let containerView = self.containerView else {
            return
        }
        
        self.removeChildViewController(self.photosCollectionViewController)
        self.photosCollectionViewController = nil
        
        self.photosTableViewController = PhotosTableTableViewController(style: .Plain)
        
        let vc = self.photosTableViewController!
        vc.photosItems = self.photosItems
        vc.delegate = self
        
        self.setupChildViewController(vc)
        self.addConstraintsToViewInContainerView(vc.view, containerView: containerView)
        
        self.view.updateConstraints()
    }
    
    private func setupPhotosCollectionViewController() {
        guard let containerView = self.containerView else {
            return
        }
        
        self.removeChildViewController(self.photosTableViewController)
        self.photosTableViewController = nil
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        self.photosCollectionViewController = PhotosCollectionViewController(collectionViewLayout: layout)
        
        let vc = self.photosCollectionViewController!
        vc.photosItems = self.photosItems
        vc.delegate = self
        
        self.setupChildViewController(vc)
        self.addConstraintsToViewInContainerView(vc.view, containerView: containerView)
        
        self.view.updateConstraints()
    }
    
    private func addConstraintsToViewInContainerView(view: UIView, containerView: UIView) {
        containerView.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        containerView.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        containerView.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        containerView.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
            )
        )
    }
    
    func segmentedControlValueChanged() {
        if self.segmentedControl?.selectedSegmentIndex == 0 {
            self.setupPhotosTableViewController()
        }
        else if self.segmentedControl?.selectedSegmentIndex == 1 {
            self.setupPhotosCollectionViewController()
        }
    }
}
