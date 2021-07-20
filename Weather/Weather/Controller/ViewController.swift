//
//  ViewController.swift
//  Weather
//
//  Created by Артем Соловьев on 19.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert){ [unowned self]
            city in self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.delegate = self
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }


}

extension ViewController: NetworkWeatherManagerDelegate{
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather){
        DispatchQueue.main.async {
        self.cityLabel.text = currentWeather.cityName
        self.temperatureLabel.text = currentWeather.temperatureString
        self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
        self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
        }
    }
}
