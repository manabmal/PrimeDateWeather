//
//  CLLocation.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 18/07/21.
//

import Foundation
import UIKit
import MapKit
extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
