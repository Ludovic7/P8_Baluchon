//
//  BaluchonConverterTests.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 01/09/2021.
//

import XCTest
@ testable import Baluchon

class BaluchonConverterServiceTests: XCTestCase {
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testsGetConverter_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataConverter.url: (nil, nil, FakeResponseDataConverter.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeConverter: ConverterService = .init(converterSession: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeConverter.getConverter() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testsGetConverter_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnErro() {
        URLProtocolFake.fakeURLs = [FakeResponseDataConverter.url: (FakeResponseDataConverter.correctData, FakeResponseDataConverter.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeConverter: ConverterService = .init(converterSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeConverter.getConverter() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetConverter_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataConverter.url: (FakeResponseDataConverter.incorrectData, FakeResponseDataConverter.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeConverter: ConverterService = .init(converterSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeConverter.getConverter() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetConverter_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnAnCorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataConverter.url: (FakeResponseDataConverter.correctData, FakeResponseDataConverter.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeConverter: ConverterService = .init(converterSession: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeConverter.getConverter() { result in
            guard case .success(let converterSuccess) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(converterSuccess == 1.183467)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    

}
