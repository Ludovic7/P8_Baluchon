//
//  FakeResponseDataConverter.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 01/09/2021.
//

import Foundation

import Baluchon

class FakeResponseDataConverter {
static let url: URL = URL(string: "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)")!
static let responseOK = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest?access_key=\(APIKeys.fixerKey)")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

class NetworkError: Error {}
static let error = NetworkError()

static var correctData: Data {
    let bundle = Bundle(for: FakeResponseDataConverter.self)
    let url = bundle.url(forResource: "Converter", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
}

static let incorrectData = "erreur".data(using: .utf8)!
}
