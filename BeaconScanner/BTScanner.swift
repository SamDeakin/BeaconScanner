////
////  BTScanner.swift
////  BeaconScanner
////
////  Created by Sam Deakin on 2015-10-24.
////  Copyright © 2015 Names Are Hard. All rights reserved.
////
//
//import Foundation
//import CoreLocation
//
///** 
// * We need NSObject so BTScanner will conform to NSObjectProtocol
// * NSObject can probably be removed if another class is inherited
// */
//class BTScanner: NSObject, CLLocationManagerDelegate {
//    let manager = CLLocationManager()
//    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "0E0A5A4C-7C12-4D89-8511-68D294225B5E")!, identifier: "vu.phuong.beacons")
//    
//    override init() {
//        super.init()
//        
//        manager.delegate = self
//        
//        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
//            manager.requestAlwaysAuthorization()
//        }
//        
//        beaconRegion.notifyOnEntry = true
//        beaconRegion.notifyOnExit = true
//        
//        // do any additional setup here
//    }
//    
//    func start() {
//        manager.startRangingBeaconsInRegion(beaconRegion)
//        manager.startUpdatingLocation()
//        let flag = (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways)
//        NSLog("%@", flag ? "true" : "false")
//    }
//    
//    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        // send a message to the scanning view saying there are beacons
//        NSLog("%@, %@", manager, region)
//    }
//    
//    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
//        // send a message to the table saying there are no beacons
//        NSLog("%@, %@", manager, region)
//    }
//    
//    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
//        // beacons is the array of beacons found
//        NSLog("%@, %@, %@", manager, region, beacons)
//    }
//    
//    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
//        fatalError("OH NO")
//    }
//    
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
//    {
//        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
//            manager.startUpdatingLocation()
//            manager.startRangingBeaconsInRegion(beaconRegion)
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didStartMonitoringRegion region: CLRegion) {
//        manager.requestStateForRegion(region)
//    }
//    
//    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
//        if state == CLRegionState.Inside {
//            manager.startRangingBeaconsInRegion(beaconRegion)
//        } else {
//            manager.stopRangingBeaconsInRegion(beaconRegion)
//        }
//    }
//}