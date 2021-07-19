//
//  LocationManager.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 18/07/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager: CLLocationManager
    typealias locationClosure = ((_ userLocation: CLLocation) -> ())
    var locationManagerClosures: [locationClosure] = []
    
    override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }
    
    //This is the main method for getting the users location and will pass back the usersLocation when it is available
    func getlocationForUser(userLocationClosure: @escaping locationClosure) {
        
        self.locationManagerClosures.append(userLocationClosure)
        
        //First need to check if the apple device has location services availabel. (i.e. Some iTouch's don't have this enabled)
        if CLLocationManager.locationServicesEnabled() {
            //Then check whether the user has granted you permission to get his location
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .notDetermined:
                    //Request permission
                    manager.requestWhenInUseAuthorization()
                case .restricted, .denied:
                    print("Sorry for you. You can huff and puff but you are not getting any location")
                case .authorizedWhenInUse:
                    // This will trigger the locationManager:didUpdateLocation delegate method to get called when the next available location of the user is available
                    manager.startUpdatingLocation()
                default:
                    manager.startUpdatingLocation()
                }
            } else {
                manager.requestWhenInUseAuthorization()
            }
        }
        
        
    }
    
    //MARK: CLLocationManager Delegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Because multiple methods might have called getlocationForUser: method there might me multiple methods that need the users location.
        //These userLocation closures will have been stored in the locationManagerClosures array so now that we have the users location we can pass the users location into all of them and then reset the array.
        let tempClosures = self.locationManagerClosures
        for closure in tempClosures {
            closure(locations[0])
        }
        self.locationManagerClosures = []
        manager.stopUpdatingLocation()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
}
