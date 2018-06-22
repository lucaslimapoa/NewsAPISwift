//
//  NewsAPIProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public class NewsAPI {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    @discardableResult
    public func request(_ target: NewsAPITarget, completion: @escaping ((Result<[NewsAPISource], NewsAPIError>) -> ())) -> URLSessionDataTask {
        completion(Result.success([NewsAPISource()]))
        return URLSessionDataTask()
    }
}
