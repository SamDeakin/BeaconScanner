//
//  ViewController.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
  
  var users = [PFUser]()
  var senderId: String!
  var senderDisplayName: String!
  
    func styleUI() {
        let smartRange = NSRange(location: 0, length: 5)
        let smartTitle = NSMutableAttributedString(string: "SMARTshop")
        smartTitle.addAttribute(NSStrokeColorAttributeName, value: UIColor.blackColor(), range: smartRange)
        smartTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor(
            red: 0.086,
            green: 0.494,
            blue: 0.984,
            alpha: 1.0
            ), range : smartRange)
        smartTitle.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(50, weight: -1), range: smartRange)
        smartTitle.addAttribute(NSStrokeWidthAttributeName, value: NSNumber(float: -1.0), range: smartRange)
        
        
        titleLabel.attributedText = smartTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch(identifier) {
            case "startScanning":
                let scanner = BTScanner()
                //scanner.setScanningViewController()
                //scanner.setTableViewController()
                scanner.start()
                if let delegate = UIApplication.sharedApplication().delegate {
                    //delegate.performSelector("setScanner", withObject: scanner)
                }
                NSLog("scanning")
                return
            default:
                return
            }
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
    
    let twitter = PFTwitterUtils.twitter()
    let twitterName = twitter!.screenName!
    
    self.senderDisplayName = twitterName
    
    let comment = PFObject(className: "CommentObject")
    comment["username"] = self.senderDisplayName
    comment["targetIt"] = "test"
    comment["rating"] = 5
    comment["content"] = "comment 123"
    
    comment.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      print("Object has been saved.")
    }
  }
  
  func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

