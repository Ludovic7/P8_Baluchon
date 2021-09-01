//
//  WeatherModel.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 25/08/2021.
//

import Foundation

class WeatherSun {
    
    private let weatherSession1: URLSession
    private var task: URLSessionTask?
    
    init(weatherSession1: URLSession = URLSession(configuration: .default)) {
        self.weatherSession1 = weatherSession1

    }
    
    func getWeather1(callback: @escaping (Result<WeatherCloud, NetworkError>) -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5905868,5128581&lang=fr&units=metric&appid=\(APIKeys.openWeatherMapKey)") else {
            callback(.failure(.invalidURL))
            return
        }
        task?.cancel()
        task = weatherSession1.dataTask(with: url) { (data, response, error) in
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

extension String {
    var data : Data? {
        guard let url = URL(string: self) else { return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
