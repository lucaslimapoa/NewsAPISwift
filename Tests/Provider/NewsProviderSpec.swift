//
//  NewsProvider.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Quick
import Nimble

@testable import NewsAPISwift

class NewsProviderSpec: QuickSpec {
    override func spec() {
        var urlSessionMock: URLSessionMock!
        var newsProvider: NewsProvider!
        
        beforeEach {
            urlSessionMock = URLSessionMock()
            newsProvider = NewsProvider(apiKey: "someKey", urlSession: urlSessionMock)
        }
        
        describe("Request") {
            it("Has X-Api-Key Header") {
                newsProvider.request(.sources(category: .all, language: .all, country: .all), completion: nil)
                
                let request = urlSessionMock.dataTask?.request
                
                expect(request?.value(forHTTPHeaderField: "X-Api-Key")) == "someKey"
            }
            
            it("Resumes Data Task") {
                let dataTask = newsProvider.request(.sources(category: .all, language: .all, country: .all), completion: nil)
                    as! URLSessionDataTaskMock
                
                expect(dataTask.resumeCalled) == true
            }
        }
    }
}

private class URLSessionDataTaskMock: URLSessionDataTask {
    var resumeCalled = false
    
    override func resume() {
        resumeCalled = true
    }
}

private class URLSessionMock: URLSession {
    var dataTask: (request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTask = (request, completionHandler)
        return URLSessionDataTaskMock()
    }
}
