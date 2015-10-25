//
//  ViewController.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit
import CoreLocation

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

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
  
  var users = [PFUser]()
  var senderId: String!
  
  var senderDisplayName: String!
    
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
    
    var cbeacon: CLBeacon?
    var beacon: Beacon?
    var rating: Double?
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
    
    // This method is called by BTScanner
    func beaconFound(beacon: CLBeacon) {
        cbeacon = beacon
        if let data = BeaconInfoController.getObjectForBeacon(cbeacon!.major, minor: cbeacon!.minor, proximityUUID: cbeacon!.proximityUUID) {
            self.beacon = data
            rating = BeaconInfoController.getRatingForBeacon(data.id)
            
            showBeacon()
        }
    }
    
    func showBeacon() {
        // Hide popupView if it is already shown, then show new
        if (!popupView.hidden) {
            overlayLeavingAnimation()
        } else {
            //Blur background
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = blurView.bounds
            blurView.addSubview(blurEffectView)
            
            updateAndShowPopupView()
        }
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
                
                self.updateAndShowPopupView()
                
                
        })
    }
    
    func updateAndShowPopupView() {
        //update pictures and shit
        //self.popupImage.image = UIImage(named: "zebra")
        //self.popupDataTitle.text = "Zebra"
        self.popupImage.image = self.beacon!.img
        self.popupDataTitle.text = self.beacon!.title
        
        //slide back in
        
        //unhide the view
        popupView.hidden = false
        overlayEntranceAnimation()
        
        styleOverlay()
    }
    
    func styleOverlay() {
        popupView.layer.cornerRadius = 10
        popupImage.roundCorners([.TopLeft , .TopRight], radius: 10)
        popupBottomView.roundCorners([.BottomLeft , .BottomRight], radius: 10)
        if let r = rating {
            starBackgroundColour.setWidth(starImage.frame.width*CGFloat(r/5))
        } else {
            starBackgroundColour.setWidth(0)
        }
    }
  
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    if (PFUser.currentUser() == nil) {
      let loginViewController = CustomLoginPage()
      loginViewController.delegate = self
      loginViewController.fields = [.Twitter]
      loginViewController.emailAsUsername = true
      loginViewController.signUpController?.delegate = self
      
      self.presentViewController(loginViewController, animated: false, completion: nil)
    }
  }
  
  func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    //Send data
    let twitter = PFTwitterUtils.twitter()
    let twitterName = twitter!.screenName!
    
    self.senderDisplayName = twitterName
    
    let comment = PFObject(className: "CommentObject")
    comment["username"] = self.senderDisplayName
    comment["targetId"] = "7103-30098"
    comment["rating"] = 5
    comment["content"] = "comment 123"
    
    comment.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      print("Object has been saved.")
    }
    
  }
  
  func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
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
      
      // Start scanning for beacons
      scanner.delegate = self
      scanner.start()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewComments") {
            let dest = segue.destinationViewController as! CommentsViewController
            dest.major = cbeacon!.major
            dest.minor = cbeacon!.minor
        }
    }
}

