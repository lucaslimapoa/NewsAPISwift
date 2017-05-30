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
    
    func test_Get_BuildsSourcesURL() {
        let expectedUrl = URL(string: "https://newsapi.org/v1/sources?category=gaming&language=en&country=us")!
        
        let expectationTest = expectation(description: "The expectedURL should match the built URL by the getSources method.")
        var actualURL: URL?
        
        subject.getSources(category: Category.gaming, language: Language.english, country: Country.unitedStates) { _, _, _ in
            actualURL = self.mockURLSession.lastURL
            expectationTest.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertNotNil(actualURL)
        XCTAssertEqual(expectedUrl, actualURL!)
    }
    
}

extension NewsAPITests {
    
    class MockURLSession: URLSessionProtocol {
        
        private (set) var lastURL: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
            self.lastURL = url
            return URLSessionDataTask()
        }
    }
    
}
