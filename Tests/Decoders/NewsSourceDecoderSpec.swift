//
//  NewsSourceDecoder.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Nimble
import Quick

@testable import NewsAPISwift

class NewsSourceDecoderSpec: QuickSpec {
    override func spec() {
        describe("NewsAPI Source JSON Decoding") {
            var newsSourceDecoder: NewsSourceDecoder!
            
            beforeEach {
                newsSourceDecoder = NewsSourceDecoder()
            }
            
            context("When Valid Data") {
                it("Returns Sources") {
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.successJsonData) }
                        == [Fakes.Sources.source]
                }
            }
            
            context("When Invalid Data") {
                it("Throws Unable To Parse Error") {
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.invalidJsonData) }
                        .to(throwError(NewsAPIError.unableToParse))
                }
            }
            
            context("When Empty Data") {
                it("Throws Unable To Parse Error") {
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.emptyJsonData) }
                        == []
                }
            }
            
            context("When Server Error Response") {
                it("Throws Service Error") {
                    expect { try newsSourceDecoder.decode(data: Fakes.NewsAPI.noApiKeyErrorJsonData) }
                        .to(throwError(NewsAPIError.serviceError(code: "apiKeyMissing",
                                                                 message: "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header.")))
                }
            }
        }
    }
}
