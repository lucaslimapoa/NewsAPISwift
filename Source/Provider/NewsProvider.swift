//
//  NewsProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

typealias NewsProviderRequestHandler = (((Data?, NewsAPIError?) -> ()))

class NewsProvider {
    private let apiKey: String
    private let urlSession: URLSession
    
    init(apiKey: String, urlSession: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    @discardableResult
    func request(_ target: NewsAPITarget, completion: NewsProviderRequestHandler?) -> URLSessionDataTask? {
        guard let urlRequest = makeUrlRequest(with: target) else {
            completion?(nil, .invalidEndpointUrl)
            return nil
        }
        
        let completionHandler = makeDataTaskCompletionHandler(completion: completion)
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: completionHandler)
        
        dataTask.resume()
        
        return dataTask
    }
}

private extension NewsProvider {
    func makeUrlRequest(with target: NewsAPITarget) -> URLRequest? {
        let urlRequestBuilder = URLRequestBuilder(url: target.endpoint, headers: ["X-Api-Key": apiKey])
        return URLRequest(builder: urlRequestBuilder)
    }
    
    func makeDataTaskCompletionHandler(completion: NewsProviderRequestHandler?) -> ((Data?, URLResponse?, Error?) -> ()) {
        return { data, response, error in
            if let data = data {
                completion?(data, nil)
                return
            }
            
            completion?(nil, .requestFailed)
        }
    }
}
