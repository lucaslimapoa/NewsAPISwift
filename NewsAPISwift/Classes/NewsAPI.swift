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
    
    private func requestData<T: BaseMappable>(urlParameters: (path: String, parameters: [URLQueryItem]), dataKey: String, completionHandler: @escaping (Result<[T]>) -> Void) {
        guard let url = buildUrl(path: urlParameters.path, parameters: urlParameters.parameters) else {
            completionHandler(Result.error(NewsAPIError.invalidUrl))
            return
        }
        
        urlSession.dataTask(with: url) { jsonData, error in
            if let error = error {
                completionHandler(Result.error(error))
                return
            }
            
            guard let dataDictionary = jsonData?[dataKey] as? [[String: Any]] else {
                completionHandler(Result.error(NewsAPIError.invalidData))
                return
            }
            
            let requestedData: [T] = Mapper<T>().mapArray(JSONArray: dataDictionary)
            
            if requestedData.count > 0 {
                completionHandler(Result.success(requestedData))
            } else {
                completionHandler(Result.error(NewsAPIError.cannotParseData))
            }
        
        }.resume()
    }
    
    /// Requests a list of sources matching the search criteria specified by the Category, Language and Country parameters.
    /// If no parameters are specified, all sources will be returned.
    public func getSources(category: Category? = nil, language: Language? = nil, country: Country? = nil, completionHandler: @escaping (Result<[NewsAPISource]>) -> Void) {
        let parameters = buildParametersArray(parameters: ("category", category?.rawValue), ("language", language?.rawValue), ("country", country?.rawValue))
        requestData(urlParameters: (sourcesPath, parameters), dataKey: "sources", completionHandler: completionHandler)
    }
    
    /// Requests a list of articles from a given SourceId, using the specified sort method. 
    /// If no sort is provided, a default one will be used by the service.
    public func getArticles(sourceId: SourceId, sortBy: SortBy? = nil, completionHandler: @escaping (Result<[NewsAPIArticle]>) -> Void) {
        let parameters = buildParametersArray(parameters: ("apiKey", key), ("source", sourceId), ("sortBy", sortBy?.rawValue))
        requestData(urlParameters: (articlesPath, parameters), dataKey: "articles", completionHandler: completionHandler)
    }
}
