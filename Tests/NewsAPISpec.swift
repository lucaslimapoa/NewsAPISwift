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
        var sourceDecoderMock: NewsSourceDecoderMock!
        
        beforeEach {
            newsProviderMock = NewsProviderMock(apiKey: "someKey")
            sourceDecoderMock = NewsSourceDecoderMock()
            newsAPI = NewsAPI(provider: newsProviderMock, sourceDecoder: sourceDecoderMock)
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
                beforeEach {
                    newsProviderMock.requestStub = (Fakes.Sources.successJsonData, nil)
                }
                
                it("Returns All Sources") {
                    sourceDecoderMock.decodeStub = [Fakes.Sources.source]
                    
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
                    sourceDecoderMock.error = .unableToParse
                    
                    newsAPI.getSources() { result in
                        if case .failure(.unableToParse) = result { } else {
                            fail("Wrong Error")
                        }
                    }
                }
            }
        }
        
        describe("Top Headlines Request") {
            context("Successfully Gets Top Headlines") {
                it("Returns Top Headlines") {
                    sourceDecoderMock.decodeStub = [Fakes.Sources.source]
                    
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
        }
    }
}

private class NewsSourceDecoderMock: NewsSourceDecoder {
    var error: NewsAPIError?
    var decodeStub = [NewsSource]()
    
    override func decode(data: Data) throws -> [NewsSource] {
        if let error = error {
            throw error
        }
        
        return decodeStub
    }
}

private class NewsProviderMock: NewsProvider {
    var requestStub: (data: Data?, error: NewsAPIError?) = (Data(), nil)
    var requestParams: (target: NewsAPITarget, completion: NewsProviderRequestHandler?)?
    
    override func request(_ target: NewsAPITarget, completion: NewsProviderRequestHandler?) -> URLSessionDataTask? {
        requestParams = (target, completion)
        completion?(requestStub.data, requestStub.error)
        
        return URLSessionDataTask()
    }
}
