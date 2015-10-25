//
//  BeaconInfo.swift
//  BeaconScanner
//
//  Created by Sam Deakin on 2015-10-24.
//  Copyright © 2015 Names Are Hard. All rights reserved.
//

import Foundation
import UIKit

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
    static let img = ["BalloonFort", "Fern", "GlitterPumpkin"]
    
    // TODO get rating by averaging comment ratings
    static let rating: [Double] = [4.4, 1.2, 5]
    
    static var comments = [
        "7103-30098": [
            Comment(commentId: "Simple", targetId: "7103-30098", rating: 4, content: "Pretty great, I liked the pretty colours"),
            Comment(commentId: "LetsNotMeet", targetId: "7103-30098", rating: 1, content: "The balloons were too easy to pop. I wasn't able to do epic battle with my arch nemesis because the roof fell in"),
            Comment(commentId: "Doge", targetId: "7103-30098", rating: 5, content: "Wow! So balloon! Very popping! Much fun!"),
            Comment(commentId: "Dissapoint", targetId: "7103-30098", rating: 1, content: "Someone popped them all"),
            Comment(commentId: "Pedro", targetId: "7103-30098", rating: 5, content: "Vote 4 Pedro"),
            Comment(commentId: "Deez Nuts", targetId: "7103-30098", rating: 5, content: "Pedro is a lie, vote Deez Nuts")],
        "7103-31098": [
            Comment(commentId: "Skeptical", targetId: "7103-31098", rating: 3, content: "Looks like a fern, the rumors of it's deadliness aren't true"),
            Comment(commentId: "Cats", targetId: "7103-31098", rating: 4, content: "I haven't seen it do anything other than be a fern, but my cats keep dissapearing..."),
            Comment(commentId: "Pedro", targetId: "7103-31098", rating: 5, content: "Vote 4 Pedro"),
            Comment(commentId: "Deez Nuts", targetId: "7103-31098", rating: 5, content: "Pedro is a lie, vote Deez Nuts"),
            Comment(commentId: "Safe", targetId: "7103-31098", rating: 1, content: "I know it prolly can't kill me, but I ain't gonna stick around and find out")],
        "7103-32098": [
            Comment(commentId: "OMG", targetId: "7103-32098", rating: 5, content: "OMG BEST THING EVAR"),
            Comment(commentId: "WTF", targetId: "7103-32098", rating: 5, content: "MY LIFE IS NOW COMPLETE"),
            Comment(commentId: "wow", targetId: "7103-32098", rating: 1, content: "Too shiny, hurt my eye"),
            Comment(commentId: "OOM", targetId: "7103-32098", rating: 5, content: "PLS HELP I'VE WASTED ALL MY MONEY ON THESE AND I CAN'T STOP"),
            Comment(commentId: "Cat", targetId: "7103-32098", rating: 5, content: "My cat's won't stop staring at it"),
            Comment(commentId: "Pedro", targetId: "7103-32098", rating: 5, content: "Vote 4 Pedro"),
            Comment(commentId: "Deez Nuts", targetId: "7103-32098", rating: 5, content: "Pedro is a lie, vote Deez Nuts"),
            Comment(commentId: "Clueless", targetId: "7103-32098", rating: 5, content: "WHO IS DEEZ NUTS?"),
            Comment(commentId: "Pink", targetId: "7103-32098", rating: 1, content: "It doesn't come in pink")]]
    
    class func getObjectForBeacon(major: NSNumber, minor: NSNumber, proximityUUID: NSUUID) -> Beacon? {
        NSLog("getObjectForBeacon: %@, %@, %@", major, minor, proximityUUID)
        if let index = self.minor.indexOf(minor) {
            NSLog("%@", img)
            NSLog("%@, %@, %@", UIImage(named:"BalloonFort")!, UIImage(named:"Fern")!, UIImage(named:"GlitterPumpkin")!)
            return Beacon(id: "\(major)-\(minor)", title: title[index], desc: description[index], img: UIImage(named:img[index])!)
        } else {
            NSLog("nil")
            return nil
        }
    }
    
    class func getRatingForBeacon(id: String) -> Double {
        if let array = comments[id] {
            var total: Double = 0
            for comment in array {
                total += Double((comment?.rating)!)
            }
            return total / Double(array.count)
        }
        return 0
    }
    
    class func getCommentsForBeacon(id: String) -> [Comment?]? {
        if let array = comments[id] {
            return array
        }
        return nil
    }
    
    /*
     * To make sure that the comments array is synchronized, to add a comment you request it here and then use the array returned
     * If nil is returned then adding a comment failed
     */
    class func addCommentForId(id: String, commentId: String, rating: Int, content: String) -> [Comment?]? {
        // TODO test this to make sure comments is actually updated
        if var array = comments[id] {
            if let comment = Comment(commentId: commentId, targetId: id, rating: rating, content: content) {
                array.append(comment)
                return array
            }
        }
        return nil
    }
}