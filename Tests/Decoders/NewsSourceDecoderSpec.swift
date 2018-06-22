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
            context("When Valid Data") {
                it("Returns Sources") {
                    let newsSourceDecoder = NewsSourceDecoder()
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.successJsonData) }
                        == [Fakes.Sources.source]
                }
            }
            
            context("When Invalid Data") {
                it("Throws Unable To Parse Error") {
                    let newsSourceDecoder = NewsSourceDecoder()
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.invalidJsonData) }
                        .to(throwError(NewsAPIError.unableToParse))
                }
            }
            
            context("When Empty Data") {
                it("Throws Unable To Parse Error") {
                    let newsSourceDecoder = NewsSourceDecoder()
                    expect { try newsSourceDecoder.decode(data: Fakes.Sources.emptyJsonData) }
                        == []
                }
            }
        }
    }
}
