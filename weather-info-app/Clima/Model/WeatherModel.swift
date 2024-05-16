//
//  WeatherModel.swift
//  Clima
//
//  Created by 박미림 on 5/15/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temparature: Double //these are stored property
    
    var tempString: String { //write data type for definig computed property
        return String(format: "%.1f", temparature)
    }
    
    var conditionName: String { //computed property //var!
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        return ""
    }
}
