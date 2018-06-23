//
//  NewsAPIProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public typealias NewsAPIRequestHandler<T> = ((Result<[T], NewsAPIError>) -> ())

public class NewsAPI {
    private let provider: NewsProvider
    private let sourceDecoder: NewsSourceDecoder
    
    public init(apiKey: String) {
        self.provider = NewsProvider(apiKey: apiKey)
        self.sourceDecoder = NewsSourceDecoder()
    }
    
    init(provider: NewsProvider, sourceDecoder: NewsSourceDecoder) {
        self.provider = provider
        self.sourceDecoder = sourceDecoder
    }
    
    @discardableResult
    public func getSources(category: NewsCategory = .all, language: NewsLanguage = .all, country: NewsCountry = .all, completion: @escaping NewsAPIRequestHandler<NewsSource>) -> URLSessionDataTask? {
        return provider.request(.sources(category: category, language: language, country: country)) { data, error in
            guard let data = data else {
                completion(.failure(error ?? .unknown))
                return
            }
            
            do {
                let sources = try self.sourceDecoder.decode(data: data)
                completion(.success(sources))
            } catch let error {
                let newsAPIError = (error as? NewsAPIError) ?? .unknown
                completion(.failure(newsAPIError))
            }
        }
    }
}
