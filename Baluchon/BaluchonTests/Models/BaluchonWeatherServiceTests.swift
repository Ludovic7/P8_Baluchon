//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 31/08/2021.
//

import XCTest
@ testable import Baluchon

class BaluchonWeatherServiceTests: XCTestCase {
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testsGetWeather_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (nil, nil, FakeResponseDataWeather.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherService = .init(weatherSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testsGetWeather_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnErro() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (FakeResponseDataWeather.correctData, FakeResponseDataWeather.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherService = .init(weatherSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetWeather_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (FakeResponseDataWeather.incorrectData, FakeResponseDataWeather.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherService = .init(weatherSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetWeather_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnAnCorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (FakeResponseDataWeather.correctData, FakeResponseDataWeather.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherService = .init(weatherSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather() { result in
            guard case .success(let weatherSuccess) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(weatherSuccess.list[0].name == "Bordeaux")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}

