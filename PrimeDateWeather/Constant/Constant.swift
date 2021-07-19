//
//  Constant.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 19/07/21.
//

import Foundation

/// Setting Base url according to environment
struct BaseUrl{
    static var apiURL: String {
        return ConstantServer.freeApiURL
    }
}

struct Token{
    static var apiToken: String {
        return ApiKey.freeToken
    }
}

/// Setting different constant server
struct ConstantServer {
    static var freeApiURL = "https://api.weatherapi.com/v1"
}

struct APIEndpoints {
    static var history: String = "/history.json"
    static var forecast: String = "/forecast.json"
}

struct ApiKey {
    static var freeToken = "ec8e9fac2b5d466196d161343211807"
}


