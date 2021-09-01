//
//  convertisseurModel.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 24/08/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case undecodableData
}


class Converter {
    
    private let converterSession: URLSession
    private var task: URLSessionTask?
    
    init(converterSession: URLSession = URLSession(configuration: .default)) {
        self.converterSession = converterSession
    }
    
    func getConverter(callback: @escaping (Result<Double, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)") else {
            callback(.failure(.invalidURL))
            return
        }
        task?.cancel()
        task = converterSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Rates.self, from: data),
                  let rate = responseJSON.rates["USD"] else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(rate))
        }
        task?.resume()
    }
}
