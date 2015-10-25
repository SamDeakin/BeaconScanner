//
//  Beacon.swift
//  BeaconScanner
//
//  Created by Ha Phuong Vu on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class Beacon {
  var id: String
  var title: String
  var desc: String
  
  init?(id: String, title: String, desc: String) {
    self.id = id
    self.title = title
    self.desc = desc
  }
}