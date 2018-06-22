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
        
        describe("Sources") {
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
                
                describe("Endpoint") {
                    context("When All Parameters Are All") {
                        it("Returns Endpoint For All Sources") {
                            expect(NewsAPITarget.sources(category: .all, language: .all, country: .all).endpoint)
                                == URL(string: "https://newsapi.org/v2/sources?")
                        }
                    }
                    
                    context("When Category Is General") {
                        it("Returns Endpoint With General Category") {
                            expect(NewsAPITarget.sources(category: .general, language: .all, country: .all).endpoint)
                                == URL(string: "https://newsapi.org/v2/sources?category=general")
                        }
                    }
                    
                    context("When Language Is English") {
                        it("Returns Endpoint With English Language") {
                            expect(NewsAPITarget.sources(category: .all, language: .en, country: .all).endpoint)
                                == URL(string: "https://newsapi.org/v2/sources?language=en")
                        }
                    }
                    
                    context("When Country Is US") {
                        it("Returns Endpoint With US Country") {
                            expect(NewsAPITarget.sources(category: .all, language: .all, country: .us).endpoint)
                                == URL(string: "https://newsapi.org/v2/sources?country=us")
                        }
                    }
                    
                    context("When Has All Parameters") {
                        it("Returns Endpoint With All Parameters") {
                            let query = NewsAPITarget
                                .sources(category: .general, language: .en, country: .us).endpoint?.query?.split(separator: "&")
                            
                            expect(query?.count) == 3
                            expect(query?.contains("category=general")) == true
                            expect(query?.contains("language=en")) == true
                            expect(query?.contains("country=us")) == true
                        }
                    }
                }
            }
        }
    }
}
