//
//  TranslateModel.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 03/09/2021.
//

import Foundation

class TranslateService {
    
    // MARK: - Properties
    
    private let translateSession: URLSession
    private var task: URLSessionTask?
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }

    // MARK: - Methodes
    
    // call the URL for take the info of the translate
    func getTranslate(textToTranslate : String, callback: @escaping (Result<Translate, NetworkError>) -> Void) {
        let scheme = "https"
        let host = "translation.googleapis.com"
        let path = "/language/translate/v2"
        let queryItemQ = URLQueryItem(name: "q", value: "\(textToTranslate)")
        let queryItemTarget = URLQueryItem(name: "target", value: "en")
        let queryItemKey = URLQueryItem(name: "key", value: "\(APIKeys.googleTranslateKey)")
        
        let urlComponents = URLComponents(scheme: scheme , host: host, path: path, queryItems: [queryItemQ, queryItemKey, queryItemTarget])
       print(urlComponents)
        guard let url = urlComponents.url else {return}
    task?.cancel()
    task = translateSession.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            callback(.failure(.noData))
            return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            callback(.failure(.invalidResponse))
            return
        }
        guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
            callback(.failure(.undecodableData))
            return
        }
        callback(.success(responseJSON))
    }
    task?.resume()
}
}

// MARK: - Extension

extension URLComponents {
    init(scheme: String ,
         host: String ,
         path: String ,
         queryItems: [URLQueryItem]) {
        self.init()
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}
