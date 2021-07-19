//
//  Location.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 18/07/21.
//

import Foundation
import MapKit
class LocationFetcher{
    lazy private var locationManager: LocationManager = LocationManager()
    func fetchCity(locationCity: @escaping (_ city: String, _ country: String, _ latLon: String) -> Void){
        self.locationManager.getlocationForUser { userLocation in
            print(userLocation)
            let lat = userLocation.coordinate.latitude
            let lon = userLocation.coordinate.longitude
            let latLon = "\(lat)" + "," + "\(lon)"
            userLocation.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                print(city + ", " + country)
                locationCity(city, country, latLon)
            }
        }
    }
}
