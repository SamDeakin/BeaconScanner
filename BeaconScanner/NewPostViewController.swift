//
//  NewPostViewController.swift
//  BeaconScanner
//
//  Created by EPM on 2015-10-25.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBAction func postPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var ratingPicker: UIPickerView!
    @IBOutlet weak var commentsInput: UITextView!
    
    override func viewDidLoad() {
        commentsInput.layer.borderColor = UIColor.blackColor().CGColor
        commentsInput.layer.borderWidth = 1
        commentsInput.layer.cornerRadius = 10
        ratingPicker.dataSource = self
        ratingPicker.delegate = self
    }
    
    var ratingOptions = ["1", "2", "3", "4", "5"]
    
    //picker functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratingOptions.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ratingOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
