//
//  ViewController.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }

    func setWidth(width: CGFloat) {
        
        var frame: CGRect = self.frame
        frame.size.width = width
        
        self.frame = frame
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var beaconSearchImage: UIView!
    @IBOutlet var searchingView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var starBackgroundColour: UIView!
    @IBOutlet weak var popupYConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupXConstraint: NSLayoutConstraint!
    @IBOutlet weak var starBackgroundWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupBottomView: UIView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var popupDataTitle: UILabel!
    @IBOutlet weak var popupImage: UIImageView!
    
    var beacon: Beacon!
    let scanner = BTScanner.sharedInstance()
    
    //temp blur on button press to simulate finding a beacon
    @IBAction func temp(sender: UIButton) {
        //Blur background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurView.addSubview(blurEffectView)
        
        //unhide the view
        popupView.hidden = false
        overlayEntranceAnimation()
        
        styleOverlay()
        
    }
    
    @IBAction func temp2(sender: AnyObject) {
        //slideout popup and populate it
        overlayLeavingAnimation()
    }
    
    // More Info is clicked and we are moving to that screen
    @IBAction func moreInfo(sender: AnyObject) {
        scanner.stop()
        
        //TODO add place for reentry and add scanner.start()
    }
    
    func overlayEntranceAnimation() {
        self.popupYConstraint.constant = 600.0
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(Double(0.5), animations: {
            self.popupYConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func overlayLeavingAnimation() {
        self.popupYConstraint.constant = 0
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(Double(0.5), animations: {
            self.popupYConstraint.constant = -600.0
            self.view.layoutIfNeeded()
        },
            completion: { finished in
                //self.popupView.hidden = true
                
                //update pictures and shit
                self.popupImage.image = UIImage(named: "zebra")
                self.popupDataTitle.text = "Zebra"
                
                //slide back in
                self.overlayEntranceAnimation()
                
                
        })
    }
    
    func styleOverlay() {
        popupView.layer.cornerRadius = 10
        popupImage.roundCorners([.TopLeft , .TopRight], radius: 10)
        popupBottomView.roundCorners([.BottomLeft , .BottomRight], radius: 10)
        
        starBackgroundColour.setWidth(starImage.frame.width*(4.2/5))
    }
    
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
        blurView.layer.insertSublayer(pulseEffect, below: beaconSearchImage.layer)
        styleUI()
        
        // Start scanning for beacons
        scanner.delegate = self
        scanner.start()
    }

}

