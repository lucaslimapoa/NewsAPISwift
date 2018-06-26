//
//  NewsProvider.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import NewsAPISwift

class NewsProviderSpec: QuickSpec {
    override func spec() {
        var urlSessionMock: URLSessionMock!
        var newsProvider: NewsProvider!
        
        afterEach {
            NetworkStub.removeAllStubs()
        }
        
        describe("Request") {
            beforeEach {
                urlSessionMock = URLSessionMock()
                newsProvider = NewsProvider(apiKey: "someKey", urlSession: urlSessionMock)
            }
            
            it("Has X-Api-Key Header") {
                newsProvider.request(Fakes.NewsAPITarget.allSourcesTarget, completion: nil)
                expect(urlSessionMock.dataTask?.request.value(forHTTPHeaderField: "X-Api-Key")) == "someKey"
                
                newsProvider.request(Fakes.NewsAPITarget.allTopHeadlines, completion: nil)
                expect(urlSessionMock.dataTask?.request.value(forHTTPHeaderField: "X-Api-Key")) == "someKey"
            }
            
            it("Resumes Data Task") {
                let dataTask = newsProvider.request(Fakes.NewsAPITarget.allSourcesTarget, completion: nil)
                    as! URLSessionDataTaskMock
                
                expect(dataTask.resumeCalled) == true
            }
        }
        
        describe("Requests Sources") {
            beforeEach {
                newsProvider = NewsProvider(apiKey: "someKey")
            }
            
            context("Successful") {
                it("Returns Data") {
                    NetworkStub.installSuccessfulRequest(data: Fakes.Sources.successJsonData)
                    
                    waitUntil(timeout: 1.0) { success in
                        newsProvider.request(Fakes.NewsAPITarget.allSourcesTarget) { data, error in
                            expect(data) == Fakes.Sources.successJsonData
                            expect(error).to(beNil())
                            success()
                        }
                    }
                }
            }
            
            context("Error") {
                it("Returns Error") {
                    NetworkStub.installFailureRequest()
                    
                    waitUntil(timeout: 1.0) { success in
                        newsProvider.request(Fakes.NewsAPITarget.allSourcesTarget) { data, error in
                            expect(data).to(beNil())
                            if case .requestFailed = error! {
                                success()
                            } else {
                                fail("Wrong Error Returned")
                            }
                        }
                    }
                }
            }
        }
        
        describe("Requests Top Headlines") {
            beforeEach {
                newsProvider = NewsProvider(apiKey: "someKey")
            }
            
            context("Successful") {
                it("Returns Data") {
                    NetworkStub.installSuccessfulRequest(data: Fakes.TopHeadlines.successTopHeadlinesJsonData)
                    
                    waitUntil(timeout: 1.0) { success in
                        newsProvider.request(Fakes.NewsAPITarget.allTopHeadlines) { data, error in
                            expect(data) == Fakes.TopHeadlines.successTopHeadlinesJsonData
                            expect(error).to(beNil())
                            success()
                        }
                    }
                }
            }
            
            context("Error") {
                it("Returns Error") {
                    NetworkStub.installFailureRequest()
                    
                    waitUntil(timeout: 1.0) { success in
                        newsProvider.request(Fakes.NewsAPITarget.allTopHeadlines) { data, error in
                            expect(data).to(beNil())
                            if case .requestFailed = error! {
                                success()
                            } else {
                                fail("Wrong Error Returned")
                            }
                        }
                    }
                }
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
