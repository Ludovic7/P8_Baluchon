//
//  Translate.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 03/09/2021.
//

import Foundation

import Foundation

// MARK: - WeatherCloud
struct Translate: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText, detectedSourceLanguage: String
}

