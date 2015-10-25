import Foundation
import CoreLocation

/** 
 * We need NSObject so BTScanner will conform to NSObjectProtocol
 * NSObject can probably be removed if another class is inherited
 */
class BTScanner: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "0E0A5A4C-7C12-4D89-8511-68D294225B5E")!, identifier: "vu.phuong.beacons")
    
    var closestBeacon: CLBeacon?
    var delegate: ViewController?
    
    var notified: Bool = false
    
    // This class should be treated as a singleton and accessed only through sharedInstance()
    static let _instance = BTScanner()
    class func sharedInstance() -> BTScanner {
        return _instance
    }
    
    override private init() {
        super.init()
        
        manager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            manager.requestAlwaysAuthorization()
        }
        
        // do any additional setup here
    }
    
    func start() {
        manager.startRangingBeaconsInRegion(beaconRegion)
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopRangingBeaconsInRegion(beaconRegion)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        // beacons is the array of beacons found
        NSLog("%@", beacons)
        if (beacons.count > 0) {
            handleFirstBeacon(beacons[0])
        }
    }
    
    // if closestBeacon is nil or if beacon is not the same as it then notify delegate
    private func handleFirstBeacon(beacon: CLBeacon) {
        NSLog("handleFirstBeacon")
        if let old = closestBeacon {
            // closestBeacon has been set before
            if (old.major != beacon.major || old.minor != beacon.minor) { // We can ignore proximity UUID for this app
                // closestBeacon is new
                notified = false
                notifyDelegate(beacon)
            } else if (!notified) {
                // notify delegate if it hasn't been yet
                notifyDelegate(beacon)
            }
        } else {
            notifyDelegate(beacon)
        }
    }
    
    // set closestBeacon to beacon then send to delegate
    private func notifyDelegate(beacon: CLBeacon) {
        closestBeacon = beacon
        NSLog("notifyDelegate")
        if let scanningView = delegate {
            // notify here because delegate is not nil
            scanningView.beaconFound(beacon)
            notified = true
        }
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        fatalError("OH NO")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            manager.startRangingBeaconsInRegion(beaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringRegion region: CLRegion) {
        manager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        if state == CLRegionState.Inside {
            manager.startRangingBeaconsInRegion(beaconRegion)
        } else {
            manager.stopRangingBeaconsInRegion(beaconRegion)
        }
    }
}

