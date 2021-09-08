//
//  FakeResponseDataWeather.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 31/08/2021.
//

import Foundation

import Baluchon

class FakeResponseDataWeather {
static let url: URL = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5905868,5128581&lang=fr&units=metric&appid=\(APIKeys.openWeatherMapKey)")!
static let responseOK = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/group?id=5905868,5128581&lang=fr&units=metric&appid=\(APIKeys.openWeatherMapKey)")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
static let responseKO = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/group?id=5905868,5128581&lang=fr&units=metric&appid=\(APIKeys.openWeatherMapKey)")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

class NetworkError: Error {}
static let error = NetworkError()

static var correctData: Data {
    let bundle = Bundle(for: FakeResponseDataWeather.self)
    let url = bundle.url(forResource: "Weather", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
}

static let incorrectData = "erreur".data(using: .utf8)!
}
