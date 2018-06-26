//
//  Tests.swift
//  Tests
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import NewsAPISwift

class NewsAPISpec: QuickSpec {
    override func spec() {
        var newsAPI: NewsAPI!
        var newsProviderMock: NewsProviderMock!
        var decoderMock: NewsSourceDecoderMock!
        
        beforeEach {
            newsProviderMock = NewsProviderMock(apiKey: "someKey")
            decoderMock = NewsSourceDecoderMock()
            
            newsAPI = NewsAPI(provider: newsProviderMock, sourceDecoder: decoderMock)
        }
        
        describe("Sources Request") {
            context("Requests All Sources") {
                it("Calls NewsProvider Correctly") {
                    newsAPI.getSources() { _ in }
                    let requestTarget = newsProviderMock.requestParams!.target
                    
                    if case .sources(category: .all, language: .all, country: .all) = requestTarget { } else {
                        fail("Wrong parameters passed")
                    }
                }
            }
            
            context("Successfully Gets Sources") {                
                it("Returns All Sources") {
                    decoderMock.sourceDecodeStub = [Fakes.Sources.source]
                    
                    waitUntil(timeout: 1.0) { success in
                        newsAPI.getSources() { result in
                            switch result {
                            case .success(let sources):
                                expect(sources.count) == 1
                                expect(sources.first) == Fakes.Sources.source
                                success()
                            case .failure(_):
                                fail()
                            }
                        }
                    }
                }
            }
            
            context("Fails To Decode Sources") {
                it("Returns Unable To Parse Error") {
                    decoderMock.error = .unableToParse
                    
                    newsAPI.getSources() { result in
                        if case .failure(.unableToParse) = result { } else {
                            fail("Wrong Error")
                        }
                    }
                }
            }
        }
        
        describe("Top Headlines Request") {
            describe("Calls NewsProvider TopHeadlines")  {
                it("Passes Parameters Correctly") {
                    newsAPI.getTopHeadlines(q: "test",
                                            sources: ["source-1"],
                                            category: .general,
                                            language: .en,
                                            country: .us,
                                            pageSize: 20,
                                            page: 1) { _ in }
                    let requestTarget = newsProviderMock.requestParams!.target
                    
                    if case .topHeadlines(q: "test",
                                          sources: ["source-1"],
                                          category: .general,
                                          language: .en,
                                          country: .us,
                                          pageSize: 20,
                                          page: 1) = requestTarget { } else {
                        fail("Wrong parameters passed")
                    }
                }
            }
            
            context("Successfully Gets Top Headlines") {
                it("Returns Top Headlines") {
                    decoderMock.headlinesDecodeStub = [Fakes.TopHeadlines.topHeadline1]
                    
                    waitUntil(timeout: 1.0) { success in
                        newsAPI.getTopHeadlines() { result in
                            switch result {
                            case .success(let articles):
                                expect(articles.count) == 1
                                expect(articles.first) == Fakes.TopHeadlines.topHeadline1
                                success()
                            case .failure(_):
                                fail()
                            }
                        }
                    }
                }
            }
        }
    }
}

private class NewsSourceDecoderMock: NewsAPIDecoder {
    var error: NewsAPIError?
    var sourceDecodeStub: [NewsSource]?
    var headlinesDecodeStub: [NewsArticle]?
    
    override func decode<T: Decodable>(data: Data, type: T.Type) throws -> [T] {
        if let error = error {
            throw error
        }
        
        let decodeStub: [T]
        
        if let sourceDecodeStub = sourceDecodeStub {
            decodeStub = sourceDecodeStub.map { $0 as! T}
        } else if let headlinesDecodeStub = headlinesDecodeStub {
            decodeStub = headlinesDecodeStub.map { $0 as! T}
        } else {
            decodeStub = []
        }
        
        return decodeStub
    }
}

private class NewsProviderMock: NewsProvider {
    var requestParams: (target: NewsAPITarget, completion: NewsProviderRequestHandler?)?
    
    override func request(_ target: NewsAPITarget, completion: NewsProviderRequestHandler?) -> URLSessionDataTask? {
        requestParams = (target, completion)
        completion?(Data(), nil)
        
        return URLSessionDataTask()
    }
}
