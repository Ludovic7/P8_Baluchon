//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 24/08/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    
    @IBOutlet weak var city1: UILabel!
    @IBOutlet weak var temperature1
: UILabel!
    @IBOutlet weak var weatherPicture: UIImageView!
    
    @IBOutlet weak var city2: UILabel!
    @IBOutlet weak var temperature2
: UILabel!
    @IBOutlet weak var weatherPicture2: UIImageView!
    
    private let weather = WeatherSun()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather1()
    }
    
    func getWeather1() {
        weather.getWeather1 { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData) :
                    self.city1.text = weatherData.list[0].name
                    self.temperature1
.text = "\(weatherData.list[0].main.temp) °C"
                    guard let icon = "http://openweathermap.org/img/wn/\(weatherData.list[0].weather[0].icon)@2x.png".data else {return}
                    self.weatherPicture.image = UIImage(data: icon)
                    self.city2.text = weatherData.list[1].name
                    self.temperature2
.text = "\(weatherData.list[1].main.temp) °C"
                    guard let icon = "http://openweathermap.org/img/wn/\(weatherData.list[1].weather[0].icon)@2x.png".data else {return}
                    self.weatherPicture2.image = UIImage(data: icon)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
