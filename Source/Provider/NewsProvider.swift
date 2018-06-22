//
//  NewsProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

typealias NewsSourceCallback = (((Result<[NewsSource], NewsAPIError>) -> ()))?

class NewsProvider {
    private let apiKey: String
    private let urlSession: URLSession
    
    init(apiKey: String, urlSession: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    @discardableResult
    func request(_ target: NewsAPITarget, completion: NewsSourceCallback) -> URLSessionDataTask? {
        let urlRequestBuilder = URLRequestBuilder(url: target.endpoint, headers: ["X-Api-Key": apiKey])
        
        guard let urlRequest = URLRequest(builder: urlRequestBuilder) else {
            completion?(.failure(.unknown))
            return nil
        }
        
        let dataTask = urlSession.dataTask(with: urlRequest)        
        dataTask.resume()
        
        return dataTask
    }
}
