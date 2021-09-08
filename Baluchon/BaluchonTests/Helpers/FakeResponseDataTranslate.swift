//
//  FakeResponseDataTranslate.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 03/09/2021.
//

import Foundation

import Baluchon

class FakeResponseDataTranslate {
static let url: URL = URL(string: "https://translation.googleapis.com/language/translate/v2?q=Bonjour&key=\(APIKeys.googleTranslateKey)&target=en")!
static let responseOK = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?q=Bonjour&key=\(APIKeys.googleTranslateKey)&target=en")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?q=Bonjour&key=\(APIKeys.googleTranslateKey)&target=en")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

class NetworkError: Error {}
static let error = NetworkError()

static var correctData: Data {
    let bundle = Bundle(for: FakeResponseDataTranslate.self)
    let url = bundle.url(forResource: "Translate", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
}

static let incorrectData = "erreur".data(using: .utf8)!
}
