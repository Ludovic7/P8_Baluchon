//
//  Baluchontranslate.swift
//  BaluchonTests
//
//  Created by Ludovic DANGLOT on 03/09/2021.
//

import XCTest
@ testable import Baluchon

class BaluchonTranslateServiceTests: XCTestCase {
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testsGetTranslate_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (nil, nil, FakeResponseDataTranslate.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeTranslate: TranslateService = .init(translateSession : fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeTranslate.getTranslate(textToTranslate: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testsGetTranslate_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnErro() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.correctData, FakeResponseDataTranslate.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeTranslate: TranslateService = .init(translateSession : fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeTranslate.getTranslate(textToTranslate: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetTranslate_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.incorrectData, FakeResponseDataTranslate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeTranslate: TranslateService = .init(translateSession : fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeTranslate.getTranslate(textToTranslate: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetTranslate_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnAnCorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.correctData, FakeResponseDataTranslate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let fakeTranslate: TranslateService = .init(translateSession : fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        fakeTranslate.getTranslate(textToTranslate: "Bonjour") { result in
            guard case .success(let translateSuccess) = result else {
                XCTFail("Test failed")
                return
            }
            XCTAssertTrue(translateSuccess.data.translations[0].translatedText == "Hello")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    

}
