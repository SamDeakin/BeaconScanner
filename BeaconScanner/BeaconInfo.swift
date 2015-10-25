//
//  BeaconInfo.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import Foundation
import UIKit

class BeaconInfo {
    var title: String?
    var description: String?
    var img: UIImage?
    var rating: Double?
    var major: NSNumber?
    var minor: NSNumber?
    var proximityUUID: NSUUID?
    
    init(title: String, description: String, img: UIImage, rating: Double, major: NSNumber, minor: NSNumber, proximityUUID: NSUUID) {
        self.title = title
        self.description = description
        self.img = img
        self.rating = rating
        self.major = major
        self.minor = minor
        self.proximityUUID = proximityUUID
    }
}



/*
 * This class is for managing the information related to the beacons
 * Ideally this would perform a lookup in some server, but aint nobody got time fo dat
 * Instead we hardcode everything
 *
 * Comments will not persist through relaunches of the app for now
 */
class BeaconInfoController {
    static let major: NSNumber = 7103
    static let minor: [NSNumber] = [30098, 31098, 32098]
    static let proximityUUID = NSUUID(UUIDString: "0E0A5A4C-7C12-4D89-8511-68D294225B5E")
    
    // static data
    static let title = [
        "Awesome Balloon Fort",
        "Possibly Deadly Fern",
        "Fabulous Pumpkin"]
    static let description = [
        "-Incredibly cool\n-Everyone will want to come over\n-Not safe for playing darts/storing porcupines/knife fights",
        "-May or may not be real\n-May or may not attempt to kill you when you turn around",
        "-You know you need this in your life"]
    static let img = [UIImage(named:"BalloonFort"), UIImage(named:"Fern"), UIImage(named:"Pumpkin")]
    
    // TODO get rating by averaging comment ratings
    static let rating: [Double] = [4.4, 1.2, 5]
    
    class func getObjectForBeacon(major: NSNumber, minor: NSNumber, proximityUUID: NSUUID) -> BeaconInfo? {
        if let index = self.minor.indexOf(minor) where self.minor == minor && self.proximityUUID!.UUIDString == proximityUUID.UUIDString {
            return BeaconInfo(title: title[index], description: description[index], img: img[index]!, rating: rating[index], major: major, minor: minor, proximityUUID: proximityUUID)
        } else {
            return nil
        }
    }
    
    // TODO add comments, get comments
}