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
        
        expectedUrl = URL(string: "https://newsapi.org/v1/sources?")!
        createdUrl = buildUrlWithParameters(category: nil, language: nil, country: nil)
        
        XCTAssertEqual(expectedUrl, createdUrl!)
    }
    
    func test_Get_Sources_ParsesJSONResponse() {
        let url = URL(string: "https://newsapi.org/v1/sources?category=gaming&language=en&country=us")!
       
        var (jsonObject, errorCode) = parseJSONResponse(url: url, jsonFile: "SourcesJSON")
        
        XCTAssertNil(errorCode)
        XCTAssertNotNil(jsonObject)
        
        (jsonObject, errorCode) = parseJSONResponse(url: url, jsonFile: "InvalidJSON")
        
        XCTAssertNil(jsonObject)
        XCTAssertNotNil(errorCode)
    }
    
    func test_Get_SourcesList() {
        let expectationTest = expectation(description: "The getSources method should return a list of sources")
        
        self.mockURLSession.jsonFile = "SourcesJSON"
        
        let ignSource = createIgnSource()
        let polygonSource = createPolygonSource()
        var actualSources: [NewsAPISource]?
        var actualError: Error?
        
        subject.getSources { result in
            switch result {
            case .success(let sources):
                actualSources = sources
            case .error(let error):
                actualError = error
            }
            
            expectationTest.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertNil(actualError)
        
        guard let sources = actualSources else {
            XCTFail("sources is nil")
            return
        }
        
        if sources.count > 0 {
            XCTAssertEqual(ignSource, actualSources?[0])
            XCTAssertEqual(polygonSource, actualSources?[1])
        } else {
            XCTFail("No sources in array")
        }
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
    
    func parseJSONResponse(url: URL, jsonFile: String) -> ([String: Any]?, Error?) {
        var errorCode: Error?
        var jsonObject: [String: Any]?
        
        let semaphore = DispatchSemaphore(value: 1)
        
        let mockDataTask = mockURLSession.dataTask(with: url) { jsonData, error in
            errorCode = error
            jsonObject = jsonData
            
            semaphore.signal()
        } as! MockURLSessionDataTask
        
        mockDataTask.jsonFile = jsonFile
        mockDataTask.resume()
        
        semaphore.wait()
        
        return (jsonObject, errorCode)
    }
    
    func createIgnSource() -> NewsAPISource {
        return NewsAPISource(id: "ign",
                             name: "IGN",
                             sourceDescription: "IGN is your site for Xbox One, PS4, PC, Wii-U, Xbox 360, PS3, Wii, 3DS, PS Vita and iPhone games with expert reviews, news, previews, trailers, cheat codes, wiki guides and walkthroughs.",
                             url: "http://www.ign.com",
                             category: Category.gaming,
                             language: Language.english,
                             country: Country.unitedStates,
                             sortBysAvailable: [SortBy.top, SortBy.latest])
    }
    
    func createPolygonSource() -> NewsAPISource {
        return NewsAPISource(id: "polygon",
                             name: "Polygon",
                             sourceDescription: "Polygon is a gaming website in partnership with Vox Media. Our culture focused site covers games, their creators, the fans, trending stories and entertainment news.",
                             url: "http://www.polygon.com",
                             category: Category.gaming,
                             language: Language.english,
                             country: Country.unitedStates,
                             sortBysAvailable: [SortBy.top])
    }
}

extension NewsAPITests {
    
    class MockURLSession: URLSessionProtocol {
        
        private (set) var lastURL: URL?
        var jsonFile: String?
        
        func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
            self.lastURL = url
            
            let dataTask = MockURLSessionDataTask(jsonFile: jsonFile, completionHandler: completionHandler)
            dataTask.jsonFile = jsonFile
            
            return dataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        let completionHandler: DataTaskResult
        var jsonFile: String?
        
        init(jsonFile: String? = nil, completionHandler: @escaping DataTaskResult) {
            self.completionHandler = completionHandler
            self.jsonFile = jsonFile
            
            super.init()
        }
        
        override open func resume() {
            var fileData: Data?
            
            if let jsonFile = jsonFile {
                let bundle = Bundle(for: type(of: self))
                let filePath = bundle.path(forResource: jsonFile, ofType: "json")!
                
                fileData = try! Data(contentsOf: URL(string: "file:///\(filePath)")!)
            }
            
            completionHandler(fileData, nil, nil)
        }
    }
}
