//
//  Double.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 19/07/21.
//

import Foundation
extension Double {
    var toCString: String {
        let strData = String(format: "%.1fºC", self)
        return strData
    }
    
    var toFString: String {
        let strData = String(format: "%.1fºF", self)
        return strData
    }
}
