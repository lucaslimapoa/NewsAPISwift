//
//  NewsAPITests.swift
//  NewsAPISwift
//
//  Created by Lucas on 30/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import NewsAPISwift

class NewsAPITests: XCTestCase {
    
    var subject: NewsAPI!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        
        self.mockURLSession = MockURLSession()
        self.subject = NewsAPI(key: "test", urlSession: self.mockURLSession)
    }
    
    func test_Get_URLSessionGetsURL() {
        let expectedUrl = URL(string: "https://newsapi.org/v1/sources?category=gaming&language=en&country=us")!
        let _ = mockURLSession.dataTask(with: expectedUrl) { _, _, _ in }
        
        XCTAssertEqual(expectedUrl, mockURLSession.lastURL)
    }
    
    func test_Get_BuildSourcesUrlWithParameters() {
        var expectedUrl = URL(string: "https://newsapi.org/v1/sources?category=gaming&language=en&country=us")!
        var createdUrl = buildUrlWithParameters(category: NewsAPISwift.Category.gaming, language: Language.english, country: Country.unitedStates)
        
        XCTAssertEqual(expectedUrl, createdUrl!)
        
        expectedUrl = URL(string: "https://newsapi.org/v1/sources?language=en&country=us")!
        createdUrl = buildUrlWithParameters(category: nil, language: Language.english, country: Country.unitedStates)
        
        XCTAssertEqual(expectedUrl, createdUrl!)
        
        expectedUrl = URL(string: "https://newsapi.org/v1/sources?country=us")!
        createdUrl = buildUrlWithParameters(category: nil, language: nil, country: Country.unitedStates)
        
        XCTAssertEqual(expectedUrl, createdUrl!)
    }
    
    func buildUrlWithParameters(category: NewsAPISwift.Category? = nil, language: NewsAPISwift.Language? = nil, country: NewsAPISwift.Country? = nil) -> URL? {
        let semaphore = DispatchSemaphore(value: 1)
        var actualUrl: URL?
        
        subject.getSources(category: category, language: language, country: country) { _ in
            actualUrl = self.mockURLSession.lastURL
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return actualUrl
    }
}

extension NewsAPITests {
    
    class MockURLSession: URLSessionProtocol {
        
        private (set) var lastURL: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
            self.lastURL = url
            return MockURLSessionDataTask(completionHandler: completionHandler)
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        let completionHandler: DataTaskResult
        
        init(completionHandler: @escaping DataTaskResult) {
            self.completionHandler = completionHandler
            super.init()
        }
        
        override open func resume() {
            completionHandler(nil, nil, nil)
        }
    }
}
