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
    
    @discardableResult
    public func getTopHeadlines(q: String? = nil,
                                sources: [String]? = nil,
                                category: NewsCategory = .all,
                                language: NewsLanguage = .all,
                                country: NewsCountry = .all,
                                pageSize: Int? = nil,
                                page: Int? = nil,
                                completion: @escaping NewsAPIRequestHandler<NewsArticle>) -> URLSessionDataTask? {
        provider.request(.topHeadlines(q: q, sources: sources, category: category, language: language, country: country, pageSize: pageSize, page: page)) { data, error in
            
        }
        
        let mockArticle = NewsArticle(source: NewsArticle.NewsSource(id: nil, name: "source 1"),
                                      author: "Source 1 Author",
                                      title: "Source 1",
                                      articleDescription: "Source 1 Description",
                                      url: URL(string: "https://www.source1.com")!,
                                      urlToImage: URL(string: "https://www.source1.com/source01.jpg"),
                                      publishedAt: Date(string: "2018-06-26T12:57:43Z"))
        completion(.success([mockArticle]))
        
        return URLSessionDataTask()
    }
}

private extension Date {
    init(string: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds]
        
        self = formatter.date(from: string)!
    }
}
