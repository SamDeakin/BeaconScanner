//
//  Comments.swift
//  BeaconScanner
//
//  Created by Ha Phuong Vu on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class Comment {
  var commentId: String
  var targetId: String
  var rating: Int
  var content: String
  var username: String
  
  init?(commentId: String, targetId: String, rating: Int, content: String, username: String) {
    self.commentId = commentId
    self.username = username
    self.targetId = targetId
    self.rating = rating
    self.content = content
  }
}
