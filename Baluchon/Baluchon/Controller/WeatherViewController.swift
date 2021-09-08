//
//  MeteoViewController.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 24/08/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - @IB Outlet
    
    @IBOutlet weak var cityBordeauxLabel: UILabel!
    @IBOutlet weak var temperatureBordeauxLabel: UILabel!
    @IBOutlet weak var weatherBordeauxImageView: UIImageView!
    
    @IBOutlet weak var cityNYLabel: UILabel!
    @IBOutlet weak var temperatureNYLabel: UILabel!
    @IBOutlet weak var weatherNYImageView: UIImageView!
    
    // MARK: - Properties
    
    private let weather = WeatherService()
    
    // MARK: - Methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
    }
    
    // MARK: - @IB Action
    
    //  Call the API for display the weather of the 2 city
    func getWeather() {
        weather.getWeather { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData) :
                    self?.cityBordeauxLabel.text = weatherData.list[0].name
                    self?.temperatureBordeauxLabel
.text = "\(weatherData.list[0].main.temp) °C"
                    guard let icon = "http://openweathermap.org/img/wn/\(weatherData.list[0].weather[0].icon)@2x.png".data else {return}
                    self?.weatherBordeauxImageView.image = UIImage(data: icon)
                    self?.cityNYLabel.text = weatherData.list[1].name
                    self?.temperatureNYLabel
.text = "\(weatherData.list[1].main.temp) °C"
                    guard let icon = "http://openweathermap.org/img/wn/\(weatherData.list[1].weather[0].icon)@2x.png".data else {return}
                    self?.weatherNYImageView.image = UIImage(data: icon)
                case .failure(let error):
                    print(error)
                    self?.didAlert(message: "Erreur de chargement des données")
                }
            }
        }
    }

}
