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
        
        beforeEach {
            newsProviderMock = NewsProviderMock(apiKey: "someKey")
            newsAPI = NewsAPI(provider: newsProviderMock)
        }
        
        describe("Sources Request") {
            context("Get All Sources") {
                beforeEach {
                    newsProviderMock.requestStub = (Fakes.Sources.successJsonData, nil)
                }
                
                it("Calls NewsProvider Correctly") {
                    newsAPI.getSources() { _ in }
                    let requestTarget = newsProviderMock.requestParams!.target
                    
                    if case .sources(category: .all, language: .all, country: .all) = requestTarget { } else {
                        fail("Wrong parameters passed")
                    }
                }
                
                it("Returns All Sources") {
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

private class NewsProviderMock: NewsProvider {
    var requestStub: (data: Data?, error: NewsAPIError?) = (Data(), nil)
    var requestParams: (target: NewsAPITarget, completion: NewsProviderRequestCallback?)?
    
    override func request(_ target: NewsAPITarget, completion: NewsProviderRequestCallback?) -> URLSessionDataTask? {
        requestParams = (target, completion)
        completion?(requestStub.data, requestStub.error)
        
        return URLSessionDataTask()
    }
}
