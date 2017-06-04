//
//  NewsAPI.swift
//  Pods
//
//  Created by Lucas on 29/05/17.
//
//

import Foundation
import ObjectMapper

public protocol NewsAPIProtocol: class {
    func getSources(category: Category?, language: Language?, country: Country?, completionHandler: @escaping (Result<[NewsAPISource]>) -> Void)
}

public class NewsAPI: NewsAPIProtocol {
    
    private let key: String
    
    private let sourcesPath = "/v1/sources"
    private let articlesPath = "/v1/articles"
    private let host = "newsapi.org"    
    
    private let urlSession: URLSessionProtocol
    
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
    
    private func buildParametersArray(parameters: (name: String, value: String?)...) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        for param in parameters {
            queryItems.append(URLQueryItem(name: param.name, value: param.value))
        }
        
        return queryItems.filter { $0.value != nil }
    }
    
    /// Requests a list of sources matching the search criteria specified by the Category, Language and Country parameters. 
    /// If no parameters are specified, all sources will be returned.
    public func getSources(category: Category? = nil, language: Language? = nil, country: Country? = nil, completionHandler: @escaping (Result<[NewsAPISource]>) -> Void) {
        let parameters = buildParametersArray(parameters: ("category", category?.rawValue), ("language", language?.rawValue), ("country", country?.rawValue))
        
        guard let url = buildUrl(path: sourcesPath, parameters: parameters) else {
            completionHandler(Result.error(NewsAPIError.invalidUrl))
            return
        }

        urlSession.dataTask(with: url) { jsonData, error in
            if let error = error {
                completionHandler(Result.error(error))
                return
            }
            
            guard let sourcesDictionary = jsonData?["sources"] as? [[String: Any]] else {
                completionHandler(Result.error(NewsAPIError.invalidData))
                return
            }
            
            do {
                let sources: [NewsAPISource] = try Mapper<NewsAPISource>().mapArray(JSONArray: sourcesDictionary)
                completionHandler(Result.success(sources))
            } catch {
                completionHandler(Result.error(NewsAPIError.cannotParseData))
            }
        }.resume()
    }
    
    public func getArticles(sourceId: SourceId, sortBy: SortBy? = nil, completionHandler: @escaping (Result<[NewsAPIArticle]>) -> Void) {
        let parameters = buildParametersArray(parameters: ("apiKey", key), ("source", sourceId), ("sortBy", sortBy?.rawValue))
        
        guard let url = buildUrl(path: articlesPath, parameters: parameters) else {
            completionHandler(Result.error(NewsAPIError.invalidUrl))
            return
        }
        
        urlSession.dataTask(with: url) { jsonData, error in
            if let error = error {
                completionHandler(Result.error(error))
                return
            }
            
            guard let articlesDictionary = jsonData?["articles"] as? [[String: Any]] else {
                completionHandler(Result.error(NewsAPIError.invalidData))
                return
            }
            
            do {
                let articles: [NewsAPIArticle] = try Mapper<NewsAPIArticle>().mapArray(JSONArray: articlesDictionary)
                completionHandler(Result.success(articles))
            } catch {
                completionHandler(Result.error(NewsAPIError.cannotParseData))
            }
            
        }.resume()
    }
}
