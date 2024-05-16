//
//  WeatherManager.swift
//  Clima
//
//  Created by 박미림 on 5/14/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    //as a convention, make protocol in the same file as the class that will use the protocol.
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=london&appid={API key}&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid={API key}&units=metric"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&appid={API key}&units=metric"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return //나가기 -> 다른 작업을 하지 않도록
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //use .self to reference the type object
           // print(decodedData.weather[0].id) //decodedData.weather[0].description
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temparature: temp)
            return weather
    
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


