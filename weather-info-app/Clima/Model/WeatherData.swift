//
//  WeatherData.swift
//  Clima
//
//  Created by 박미림 on 5/15/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
//WeatherData.main.temp
//WeatherData.weather[0].description

//Typealias *Codable* combines Decodable and Encodable
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather] //array!
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
