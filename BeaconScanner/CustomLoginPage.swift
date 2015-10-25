//
//  CustomLoginPage.swift
//  BeaconScanner
//
//  Created by Ha Phuong Vu on 2015-10-25.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class CustomLoginPage: PFLogInViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.blackColor()
    
    let label = UILabel()
    label.textColor = UIColor.whiteColor()
    label.text = "uPlan"
    label.font = UIFont (name: "HelveticaNeue-UltraLight", size: 30)
    logInView?.logo = label
  }
  
}