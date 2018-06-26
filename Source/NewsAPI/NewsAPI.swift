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
    private let decoder: NewsAPIDecoder
    
    public init(apiKey: String) {
        self.provider = NewsProvider(apiKey: apiKey)
        self.decoder = NewsAPIDecoder()
    }
    
    init(provider: NewsProvider, sourceDecoder: NewsAPIDecoder) {
        self.provider = provider
        self.decoder = sourceDecoder
    }
    
    @discardableResult
    public func getSources(category: NewsCategory = .all, language: NewsLanguage = .all, country: NewsCountry = .all, completion: @escaping NewsAPIRequestHandler<NewsSource>) -> URLSessionDataTask? {
        let targetAPI = NewsAPITarget.sources(category: category, language: language, country: country)
        return request(targetAPI, completion: completion)
    }
    
    @discardableResult
    public func getTopHeadlines(q: String? = nil,
                                sources: [String]? = nil,
                                category: NewsCategory = .all,
                                language: NewsLanguage = .all,
                                country: NewsCountry = .all,
                                pageSize: Int? = nil,
                                page: Int? = nil,
                                completion: @escaping NewsAPIRequestHandler<NewsArticle>) -> URLSessionDataTask? {
        let targetAPI = NewsAPITarget.topHeadlines(q: q, sources: sources, category: category, language: language, country: country, pageSize: pageSize, page: page)
        return request(targetAPI, completion: completion)
    }
}

private extension NewsAPI {
    func request<T: Decodable>(_ target: NewsAPITarget, completion: @escaping NewsAPIRequestHandler<T>) -> URLSessionDataTask? {
        return provider.request(target) { data, error in
            guard let data = data else {
                completion(.failure(error ?? .unknown))
                return
            }
            
            do {
                let result: [T] = try self.decoder.decode(data: data, type: T.self)
                completion(.success(result))
            } catch let error {
                let newsAPIError = (error as? NewsAPIError) ?? .unknown
                completion(.failure(newsAPIError))
            }
        }
    }
}
