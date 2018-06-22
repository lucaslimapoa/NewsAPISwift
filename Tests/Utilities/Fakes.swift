//
//  Fakes.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation
import NewsAPISwift

struct Fakes { }

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
                                          description: "Source Description",
                                          url: URL(string: "http://source.com")!,
                                          category: .general,
                                          language: .en,
                                          country: .us)
    }
}
