//
//  Fakes.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation
import NewsAPISwift

struct Fakes {
    struct NewsAPI {
        static let noApiKeyErrorJsonData =
        """
        {
            "status": "error",
            "code": "apiKeyMissing",
            "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."
        }
        """.data(using: .utf8)!
    }
}

extension Fakes {
    struct Sources {
        static let successJsonData =
        """
        {
           "status":"ok",
           "sources":[
              {
                 "id":"source-id",
                 "name":"Source",
                 "description":"Source Description",
                 "url":"http://source.com",
                 "category":"general",
                 "language":"en",
                 "country":"us"
              }
           ]
        }
        """.data(using: .utf8)!
        
        static let invalidJsonData =
        """
        {
           "status":"ok",
           "sources":[
              {
                 "id":"source-id",
                 "name":"Source",
                 "description":"Source Description",                 
                 "category":"general",
                 "language":"en",
                 "country":"us"
              }
           ]
        }
        """.data(using: .utf8)!
        
        static let emptyJsonData =
        """
        {
           "status":"ok",
           "sources":[]
        }
        """.data(using: .utf8)!
        
        static let source = NewsSource(id: "source-id",
                                          name: "Source",
                                          sourceDescription: "Source Description",
                                          url: URL(string: "http://source.com")!,
                                          category: .general,
                                          language: .en,
                                          country: .us)
    }
}

extension Fakes {
    struct TopHeadlines {
        static let successTopHeadlinesJsonData =
            """
        {
            "status": "ok",
            "totalResults": 1,
            "articles": [
                {
                    "source": {
                        "id": null,
                        "name": "source 1"
                    },
                    "author": "Source 1 Author",
                    "title": "Source 1",
                    "description": "Source 1 Description",
                    "url": "https://www.source1.com",
                    "urlToImage": "https://www.source1.com/source01.jpg",
                    "publishedAt": "2018-06-26T12:57:43Z"
                }
            ]
        }
        """.data(using: .utf8)!
        
        static let topHeadline1 = NewsArticle(source: NewsArticle.NewsSource(id: nil, name: "source 1"),
                                              author: "Source 1 Author",
                                              title: "Source 1",
                                              articleDescription: "Source 1 Description",
                                              url: URL(string: "https://www.source1.com")!,
                                              urlToImage: URL(string: "https://www.source1.com/source01.jpg"),
                                              publishedAt: Date(string: "2018-06-26T12:57:43Z"))
    }
}
