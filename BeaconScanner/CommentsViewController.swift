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
    
    var major: NSNumber!
    var minor: NSNumber!
  
  @IBOutlet var tableView: UITableView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
    
    
    func postButtonSegue() {
        
        //let nextVC = NewPostViewController()
        self.performSegueWithIdentifier("toPostComments", sender: self)
        //self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
  
  override func viewDidLoad() {
    
    //let postButton = UIBarButtonItem()
    //postButton.title = "Post"
    //optionButton.action = something (put your action here)

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: "postButtonSegue")

    let comment1 = Comment(commentId: "test", targetId: "7103-30098", rating: 3, content: "Perfect place to build a tower", username: "Kim")
    let comment2 = Comment(commentId: "test", targetId: "7103-30098", rating: 5, content: "The building is so good!", username: "Heyaa")
    let comment3 = Comment(commentId: "test", targetId: "7103-30098", rating: 4, content: "This will make the city better!", username: "Mr.T")
    let comment4 = Comment(commentId: "test", targetId: "7103-30098", rating: 2, content: "Not a good place to build a tower", username: "Thomas")
    
    let comment5 = Comment(commentId: "test", targetId: "7103-31098", rating: 2, content: "Not a place to build a house", username: "Lola")
    let comment6 = Comment(commentId: "test", targetId: "7103-31098", rating: 1, content: "The building is so bad!", username: "Lukas")
    let comment7 = Comment(commentId: "test", targetId: "7103-31098", rating: 1, content: "This area is so bad!", username: "Mr.T")
    let comment8 = Comment(commentId: "test", targetId: "7103-31098", rating: 2, content: "Not a good place to build a tower", username: "Tuomas")
    
    let comment9 = Comment(commentId: "test", targetId: "7103-32098", rating: 3, content: "Not a place to build a house", username: "Xi Ji")
    let comment10 = Comment(commentId: "test", targetId: "7103-32098", rating: 2, content: "The building is so bad!", username: "Murakami")
    let comment11 = Comment(commentId: "test", targetId: "7103-32098", rating: 4, content: "This area is not so bad!", username: "Mr.T")
    let comment12 = Comment(commentId: "test", targetId: "7103-32098", rating: 2, content: "Not a good place to build a tower", username: "Deakin")

    
    self.comments.append(comment1!)
    self.comments.append(comment2!)
    self.comments.append(comment3!)
    self.comments.append(comment4!)
    
    self.comments.append(comment5!)
    self.comments.append(comment6!)
    self.comments.append(comment7!)
    self.comments.append(comment8!)
    
    self.comments.append(comment9!)
    self.comments.append(comment10!)
    self.comments.append(comment11!)
    self.comments.append(comment12!)
    
    //Retrieve data
    let query = PFQuery(className:"CommentObject")
    let beaconId = "\(major)-\(minor)"
    
    query.whereKey("targetId", equalTo: beaconId)
    
    query.findObjectsInBackgroundWithBlock { objects, error in
      if error == nil {
        
        for object in objects! {
          let comment = Comment(commentId: "test", targetId: object.objectForKey("targetId") as! String, rating: object.objectForKey("rating") as! Int, content: object.objectForKey("content") as! String, username: object.objectForKey("username") as! String)
          self.comments.append(comment!);
        }
        //Reload
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.tableView.reloadData()
        })
        
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
    let comment = self.comments[indexPath.row]
    cell.username.text = comment.username
    cell.comment.text = comment.content
    cell.rating.text = String(comment.rating) + " Stars"
    //Return it
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.comments.count
  }
}
