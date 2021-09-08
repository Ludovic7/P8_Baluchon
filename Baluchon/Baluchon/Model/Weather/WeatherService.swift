//
//  WeatherModel.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 25/08/2021.
//

import Foundation

class WeatherService {
    
    // MARK: - Properties
    
    private let weatherSession: URLSession
    private var task: URLSessionTask?
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession

    }
    
    // MARK: - Methodes
    
    // call the URL for take the info of the weather
    func getWeather(callback: @escaping (Result<WeatherCloud, NetworkError>) -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5905868,5128581&lang=fr&units=metric&appid=\(APIKeys.openWeatherMapKey)") else {return}
        task?.cancel()
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let responseJSON1 = try? JSONDecoder().decode(WeatherCloud.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseJSON1))
        }
        task?.resume()
    }
}


