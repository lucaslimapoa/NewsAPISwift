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
                expect(Fakes.NewsAPITarget.allSources.baseUrl) == "https://newsapi.org"
            }
        }
        
        
        describe("Sources") {
            it("Has Path") {
                expect(Fakes.NewsAPITarget.allSources.path) == "/v2/sources"
            }
            
            describe("Parameters") {
                context("When All Parameters Are All") {
                    it("Returns All Parameters") {
                        expect(Fakes.NewsAPITarget.allSources.parameters)
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
        
        
        describe("Top Headlines") {
            it("Has Path") {
                expect(Fakes.NewsAPITarget.allTopHeadlines.path) == "/v2/top-headlines"
            }
            
            describe("Parameters") {
                context("When All Parameters Are Default") {
                    it("Returns All Parameters") {
                        expect(Fakes.NewsAPITarget.allTopHeadlines.parameters)
                            == [:]
                    }
                }
                
                it("Sets Q Parameter When Available") {
                    let allTopHeadlines = NewsAPITarget.topHeadlines(q: "q", sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    expect(allTopHeadlines.parameters)
                        == ["q": "q"]
                }
                
                it("Sets Category Parameter When Not .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .general, language: .all, country: .all, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == ["category": "general"]
                }
                
                it("Returns Empty When Category Parameter Is .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == [:]
                }
                
                it("Sets Language Parameter When Not .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .en, country: .all, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == ["language": "en"]
                }
                
                it("Returns Empty When Language Parameter Is .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == [:]
                }
                
                it("Sets Country Parameter When Not .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .us, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == ["country": "us"]
                }
                
                it("Returns Empty When Country Parameter Is .all") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    expect(topHeadlines.parameters)
                        == [:]
                }
                
                it("Sets Page Size Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: 20, page: nil)
                    expect(topHeadlines.parameters)
                        == ["pageSize": "20"]
                }
                
                it("Sets Page Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: 1)
                    expect(topHeadlines.parameters)
                        == ["page": "1"]
                }
                
                context("When Sources Parameter Has One Item") {
                    it("Sets Single Sources Parameter") {
                        let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: ["sources"], category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                        expect(topHeadlines.parameters)
                            == ["sources": "sources"]
                    }
                }
                
                context("When Sources Parameter Has More Than One Item") {
                    it("Sets Sources Parameter With Commas") {
                        let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: ["sources1", "sources2"], category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                        expect(topHeadlines.parameters)
                            == ["sources": "sources1,sources2"]
                    }
                }
            }
            
            describe("Endpoint") {
                context("When All Parameters Are All") {
                    it("Returns Endpoint For All Sources") {
                        expect(Fakes.NewsAPITarget.allTopHeadlines.endpoint)
                            == URL(string: "https://newsapi.org/v2/top-headlines?")
                    }
                }
                
                it("Returns Endpoint With Q Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: "test", sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?q=test")
                }
                
                it("Sets Sources Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: ["source1", "source2"], category: .all, language: .all, country: .all, pageSize: nil, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?sources=source1,source2")
                }
                
                it("Sets Category Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .general, language: .all, country: .all, pageSize: nil, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?category=general")
                }
                
                it("Sets Language Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .en, country: .all, pageSize: nil, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?language=en")
                }
                
                it("Sets Country Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .us, pageSize: nil, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?country=us")
                }
                
                it("Sets Page Size Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: 20, page: nil)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?pageSize=20")
                }
                
                it("Sets Page Parameter When Available") {
                    let topHeadlines = NewsAPITarget.topHeadlines(q: nil, sources: nil, category: .all, language: .all, country: .all, pageSize: nil, page: 2)
                    
                    expect(topHeadlines.endpoint)
                        == URL(string: "https://newsapi.org/v2/top-headlines?page=2")
                }
            }
        }
    }
}
