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
    var max_temp: Int
    var min_temp: Int
    var date: String
}

protocol WeatherProtocol {
    func fetchWeather(_ jsonString: String) throws -> String
}
