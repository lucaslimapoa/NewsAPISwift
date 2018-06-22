//
//  Tests.swift
//  Tests
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Quick
import Nimble

import NewsAPISwift

class NewsAPISpec: QuickSpec {
    override func spec() {
        var newsAPI: NewsAPI!
        
        beforeEach {
            newsAPI = NewsAPI(apiKey: "someKey")
        }
        
        describe("Requests") {
            it("Returns URLSessionDataTask") {
                expect(newsAPI.request(.sources(category: .all, language: .all, country: .all), completion: { _ in }))
                    .to(beAKindOf(URLSessionDataTask.self))
            }
        }
        
        describe("Sources Request") {
            it("All Sources") {
                waitUntil(timeout: 1.0) { done in
                    newsAPI.request(.sources(category: .all, language: .all, country: .all)) { result in
                        switch result {
                        case .success(let sources):
                            expect(sources.count) == 1
                            done()
                        case .failure(_):
                            fail()
                        }
                    }
                }
            }
        }
    }
}
