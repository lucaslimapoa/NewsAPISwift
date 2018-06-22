//
//  NewsProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

typealias NewsProviderRequestCallback = (((Data?, NewsAPIError?) -> ()))?

class NewsProvider {
    private let apiKey: String
    private let urlSession: URLSession
    
    init(apiKey: String, urlSession: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    @discardableResult
    func request(_ target: NewsAPITarget, completion: NewsProviderRequestCallback) -> URLSessionDataTask? {
        let urlRequestBuilder = URLRequestBuilder(url: target.endpoint, headers: ["X-Api-Key": apiKey])
        
        guard let urlRequest = URLRequest(builder: urlRequestBuilder) else {
            completion?(nil, .unknown)
            return nil
        }
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                completion?(data, nil)
                return
            }
            
            completion?(nil, .requestFailed)
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
