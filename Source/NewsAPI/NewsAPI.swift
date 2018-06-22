//
//  NewsAPIProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public typealias NewsAPISourceRequest = ((Result<[NewsSource], NewsAPIError>) -> ())

public class NewsAPI {
    private let provider: NewsProvider
    
    public init(apiKey: String) {
        self.provider = NewsProvider(apiKey: apiKey)
    }
    
    init(provider: NewsProvider) {
        self.provider = provider
    }
    
    @discardableResult
    public func getSources(category: NewsCategory = .all, language: NewsLanguage = .all, country: NewsCountry = .all, completion: @escaping NewsAPISourceRequest) -> URLSessionDataTask? {
        return provider.request(.sources(category: category, language: language, country: country)) { data, error in
            guard let data = data else {
                completion(.failure(error ?? .unknown))
                return
            }
            
            do {
                let sources = try NewsSourceDecoder().decode(data: data)
                completion(.success(sources))
            } catch let error {
                let newsAPIError = (error as? NewsAPIError) ?? .unknown
                completion(.failure(newsAPIError))
            }
        }
    }
}
