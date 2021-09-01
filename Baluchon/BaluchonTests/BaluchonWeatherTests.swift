//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 31/08/2021.
//

import XCTest
@ testable import Baluchon

class BaluchonWeatherTests: XCTestCase {
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testsGetWeather_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (nil, nil, FakeResponseDataWeather.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherSun = .init(weatherSession1: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather1() { result in
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
        let fakeWeather: WeatherSun = .init(weatherSession1: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather1() { result in
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
        let fakeWeather: WeatherSun = .init(weatherSession1: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather1() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetWeather_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataWeather.url: (FakeResponseDataWeather.correctData, FakeResponseDataWeather.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeWeather: WeatherSun = .init(weatherSession1: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeWeather.getWeather1() { result in
            guard case .success(let weatherSuccess) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}

