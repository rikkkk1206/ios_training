//
//  CommunicateWeatherData.swift
//  Training-2
//
//  Created by RIKU on 2022/01/23.
//

import Foundation

struct RequestUserData: Codable {
    var area: String
    var date: String
}

struct ResponseWeatherData: Codable {
    var weather: String
    var maxTemp: Int
    var minTemp: Int
    var date: String
}
