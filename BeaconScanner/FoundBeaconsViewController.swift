//
//  FoundBeaconsView.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class FoundBeaconsViewController: UITableViewController {
    
    var beacons: [CLBeacon] = []
    
    override init(style: UITableViewStyle) {
        super.init(style: style);
        
        // Add extra initialization here
    }
    
    required init?(coder aDecoder: NSCoder) {
        // TODO this is probably important
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Beacon")! as UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Beacon")
        }
        
        
        
        
        return cell!;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // This is assuming every beacon will take up 1 cell so we only need one section to deal with each beacon
        return 1;
    }
    
    //override func
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Currently no table section headers
        return nil;
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // Curretnly no table section footers
        return nil;
    }
    
    func foundBeacons(found: [CLBeacon]) {
        beacons = found
        if (beacons.count == 0) {
            // TODO popup no beacons and dismiss self
        }
    }
}