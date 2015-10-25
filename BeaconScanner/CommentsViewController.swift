//
//  CommentsViewController.swift
//  BeaconScanner
//
//  Created by Ha Phuong Vu on 2015-10-25.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var comments = [Comment]()
    
    var major: NSNumber?
    var minor: NSNumber?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func viewDidLoad() {
    
    let optionButton = UIBarButtonItem()
    optionButton.title = "Post"
    //optionButton.action = something (put your action here)
    self.navigationItem.rightBarButtonItem = optionButton
    
    //Retrieve data
    let query = PFQuery(className:"CommentObject")
    query.whereKey("targetId", equalTo:"test")
    
    query.findObjectsInBackgroundWithBlock { objects, error in
      if error == nil {
        for object in objects!.reverse() {
          print(object)
//          comments.append(new Comment(object[""]))
        }
      } else {
        print("Error");
      }
      
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //Create the cell
    let cellIdentifier = "CommentCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CommentsTableViewCell
    //Customize it
    let comment = comments[indexPath.row]
    cell.username.text = comment.username
    cell.comment.text = comment.content
    //Return it
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
}
