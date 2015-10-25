//
//  CommentsTableViewCell.swift
//  BeaconScanner
//
//  Created by Ha Phuong Vu on 2015-10-25.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
  

  @IBOutlet weak var username: UILabel!
  
  @IBOutlet weak var comment: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
