//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Артем Соловьев on 19.07.2021.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManagerDelegate: AnyObject {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}
class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitute: CLLocationDegrees, longitute: CLLocationDegrees)
    }
    
    weak var delegate:NetworkWeatherManagerDelegate?
    
    func fetchCurrentWeather(forRequestType requestType:RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitute):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitute)&apikey=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                if let currentWeather = self.parseJSON(withData: data){
                    self.delegate?.updateInterface(self, with: currentWeather)
                }
            }
        }//запрос данных
        task.resume()
    }
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        return nil
        
    }
}
