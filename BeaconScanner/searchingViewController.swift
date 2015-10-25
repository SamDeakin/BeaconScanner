//
//  searchingViewController.swift
//  BeaconScanner
//
//  Created by EPM on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class searchingViewController: UIViewController {
    
    @IBOutlet weak var topNav: UIView!
    @IBOutlet var searchingView: UIView!
    @IBOutlet weak var beaconSearchIcon: NSLayoutConstraint!
    
    func styleUI() {
        func styleUI() {
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRectMake(0.0, topNav.frame.size.height - 1, topNav.frame.size.width, 1.0);
            bottomBorder.backgroundColor = UIColor.blackColor().CGColor
            topNav.layer.borderWidth = 5
            topNav.layer.addSublayer(bottomBorder)
            
        }
    }
    
    override func viewDidLoad() {
        let pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:150, position:searchingView.center)
        pulseEffect.pulseInterval = 0
        pulseEffect.backgroundColor = UIColor(
            red: 0.086,
            green: 0.494,
            blue: 0.984,
            alpha: 1.0
            ).CGColor
        searchingView.layer.insertSublayer(pulseEffect, below: searchingView.layer)
        
        styleUI()
    }

}
