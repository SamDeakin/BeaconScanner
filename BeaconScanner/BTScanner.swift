//
//  BTScanner.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import Foundation
import CoreLocation

/** 
 * We need NSObject so BTScanner will conform to NSObjectProtocol
 * NSObject can probably be removed if another class is inherited
 */
class BTScanner: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // send a message to the scanning view saying there are beacons
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        // send a message to the table saying there are no beacons
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        // beacons is the array of beacons found
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        fatalError("OH NO")
    }
}