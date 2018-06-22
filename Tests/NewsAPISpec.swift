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

import NewsAPISwift

class NewsAPISpec: QuickSpec {
    override func spec() {
        var newsAPI: NewsAPI!
        
        beforeEach {
            newsAPI = NewsAPI(apiKey: "someKey")
        }
        
        describe("Requests") {
            it("Returns URLSessionDataTask") {
                expect(newsAPI.request(.sources(category: .all, language: .all, country: .all)) { _ in })
                    .to(beAKindOf(URLSessionDataTask.self))
            }
        }
        
        describe("Sources Request") {
            context("Successful Request") {
                beforeEach {
                    stub(condition: isHost("newsapi.org")) { _ in                        
                        return OHHTTPStubsResponse(data: Fakes.Sources.successJsonData,
                                                   statusCode: 200,
                                                   headers: ["Content-Type":"application/json"])
                    }
                }
                
                context("Get All Sources") {
                    it("Returns All Sources") {
                        waitUntil(timeout: 3.0) { success in
                            newsAPI.request(.sources(category: .all, language: .all, country: .all)) { result in
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
}
