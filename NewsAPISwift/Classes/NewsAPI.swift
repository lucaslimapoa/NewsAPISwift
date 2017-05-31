//
//  NewsAPI.swift
//  Pods
//
//  Created by Lucas on 29/05/17.
//
//

import Foundation

public typealias NewsAPISourcesResult = ([NewsAPISource]?, NewsAPIError?, NewsAPIResponse?) -> Void

public enum NewsAPIError: Error {
    case invalidUrl
}

public enum NewsAPIResponse {
    
}

public protocol NewsAPIProtocol: class {
    func getSources(category: Category?, language: Language?, country: Country?, completionHandler: @escaping NewsAPISourcesResult)
}

public class NewsAPI: NewsAPIProtocol {
    
    private let key: String
    
    private let sourcesPath = "/v1/sources"
    private let articlesPath = "/v1/articles"
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
    
    private func buildUrl(path: String, parameters: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.host
        urlComponents.path = path
        urlComponents.queryItems = parameters
        
        return urlComponents.url
    }
    
    public func getSources(category: Category? = nil, language: Language? = nil, country: Country? = nil, completionHandler: @escaping NewsAPISourcesResult) {
        let queryItems = [
            URLQueryItem(name: "category", value: category?.rawValue),
            URLQueryItem(name: "language", value: language?.rawValue),
            URLQueryItem(name: "country", value: country?.rawValue)
        ]
        
        guard let url = buildUrl(path: sourcesPath, parameters: queryItems) else {
            completionHandler(nil, NewsAPIError.invalidUrl, nil)
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            completionHandler(nil, nil, nil)
        }
        
        dataTask.resume()
    }
}
