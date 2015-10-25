//
//  searchingViewController.swift
//  BeaconScanner
//
//  Created by EPM on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class searchingViewController: UIViewController {
    
    @IBOutlet weak var beaconSearchImage: UIView!
    @IBOutlet var searchingView: UIView!
    @IBOutlet weak var backToMainButton: UIButton!
    
    func styleUI() {
        
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
        searchingView.layer.insertSublayer(pulseEffect, below: beaconSearchImage.layer)
        
        styleUI()
    }

}
