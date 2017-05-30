//
//  NewsAPI.swift
//  Pods
//
//  Created by Lucas on 29/05/17.
//
//

import Foundation

public typealias NewsAPISourcesResult = ([NewsAPISource]?, NewsAPIError?, NewsAPIResponse) -> Void

public enum NewsAPIError: Error {
    
}

public enum NewsAPIResponse {
    
}

public protocol NewsAPIProtocol: class {
    func getSources(category: Category?, language: Language?, country: Country?, completionHandler: @escaping NewsAPISourcesResult)
}

public class NewsAPI: NewsAPIProtocol {
    
    private let key: String
    
    private let sourcesPath = "/v1/sources/"
    private let articlesPath = "/v1/articles/"
    private let host = "newsapi.org"    
    
    let urlSession: URLSessionProtocol
    
    public init(key: String) {
        self.key = key
        self.urlSession = URLSession.shared
    }
    
    init(key: String, urlSession: URLSessionProtocol) {
        self.key = key
        self.urlSession = urlSession
    }
    
    private func buildUrl(path: String, parameters: [String: String?]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.host
        urlComponents.path = path
        
        var queryItems = [URLQueryItem]()
        
        for (key,value) in parameters {
            if let value = value {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    public func getSources(category: Category? = nil, language: Language? = nil, country: Country? = nil, completionHandler: @escaping NewsAPISourcesResult) {
        
    }
}
