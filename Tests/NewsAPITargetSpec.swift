//
//  NewsProviderSpec.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Nimble
import Quick

@testable import NewsAPISwift

class NewsAPITargetSpec: QuickSpec {
    override func spec() {
        describe("NewsAPI") {
            it("baseUrl") {
                expect(NewsAPITarget.sources(category: .all, language: .all, country: .all).baseUrl) == "https://newsapi.org"
            }
        }
        
        describe("Sources Endpoint") {
            it("Has Path") {
                expect(NewsAPITarget.sources(category: .all, language: .all, country: .all).path) == "/v2/sources"
            }
            
            describe("Parameters") {
                context("When All Parameters Are All") {
                    it("Returns All Parameters") {
                        expect(NewsAPITarget.sources(category: .all, language: .all, country: .all).parameters)
                            == [:]
                    }
                }
                
                context("When Category Is General") {
                    it("Returns General Category") {
                        expect(NewsAPITarget.sources(category: .general, language: .all, country: .all).parameters)
                            == ["category": "general"]
                    }
                }
                
                context("When Language Is English") {
                    it("Returns English Language") {
                        expect(NewsAPITarget.sources(category: .all, language: .en, country: .all).parameters)
                            == ["language": "en"]
                    }
                }
                
                context("When Language Is English") {
                    it("Returns English Language") {
                        expect(NewsAPITarget.sources(category: .all, language: .en, country: .all).parameters)
                            == ["language": "en"]
                    }
                }
                
                context("When Country is US") {
                    it("Returns US Country") {
                        expect(NewsAPITarget.sources(category: .all, language: .all, country: .us).parameters)
                            == ["country": "us"]
                    }
                }
                
                context("When Has Values For All Parameters") {
                    it("Returns All Parameters") {
                        let parameters = NewsAPITarget.sources(category: .general, language: .en, country: .us).parameters
                        expect(parameters.count) == 3
                        expect(parameters["category"]) == "general"
                        expect(parameters["language"]) == "en"
                        expect(parameters["country"]) == "us"
                    }
                }
            }
        }
    }
}
