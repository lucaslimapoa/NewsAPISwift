//
//  URLRequestBuilder.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

class URLRequestBuilder {
    var url: URL?
    var headers: [String: String]?
    
    init(url: URL? = nil, headers: [String: String]? = nil) {
        self.url = url
        self.headers = headers
    }
}

extension URLRequest {
    typealias BuilderClosure = ((URLRequestBuilder) -> ())
    
    init?(builder: URLRequestBuilder) {
        guard let url = builder.url else { return nil }
        self.init(url: url)
        
        if let headers = builder.headers {
            self.allHTTPHeaderFields = headers
        }
    }    
}
