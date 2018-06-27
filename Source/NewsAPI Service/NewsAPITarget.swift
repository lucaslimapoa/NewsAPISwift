//
//  NewsAPITarget.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public enum NewsAPITarget {
    case sources(category: NewsCategory, language: NewsLanguage, country: NewsCountry)
    case topHeadlines(q: String?, sources: [String]?, category: NewsCategory, language: NewsLanguage, country: NewsCountry, pageSize: Int?, page: Int?)
}

extension NewsAPITarget: APITargetType {
    var baseUrl: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .sources(_, _, _):
            return "/v2/sources"
        case .topHeadlines(_, _, _, _, _, _, _):
            return "/v2/top-headlines"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case let .sources(category, language, country):
            return makeSourceParameters(category: category, language: language, country: country)
        case let .topHeadlines(q, sources, category, language, country, pageSize, page):
            return makeTopHeadlinesParameters(q: q, sources: sources, category: category, language: language, country: country, pageSize: pageSize, page: page)
        }
    }
    
    var endpoint: URL? {
        switch self {
        case .sources(_, _, _):
            return makeSourceEndpoint(baseUrl: self.baseUrl, path: self.path, parameters: self.parameters)
        default:
            return URL(string: "http://newsapi.org")!
        }
    }
}

private extension NewsAPITarget {
    func makeSourceParameters(category: NewsCategory, language: NewsLanguage, country: NewsCountry) -> [String: String] {
        var parameters = [String: String]()
        
        if case .all = category {} else {
            parameters["category"] = category.rawValue
        }
        
        if case .all = language {} else {
            parameters["language"] = language.rawValue
        }
        
        if case .all = country {} else {
            parameters["country"] = country.rawValue
        }
        
        return parameters
    }
    
    func makeTopHeadlinesParameters(q: String?, sources: [String]?, category: NewsCategory, language: NewsLanguage, country: NewsCountry, pageSize: Int?, page: Int?) -> [String: String] {
        var parameters = [String: String]()
        
        if let q = q {
            parameters["q"] = q
        }
        
        if let sources = sources {
            parameters["sources"] = sources.joined(separator: ",")
        }
        
        if case .all = category {} else {
            parameters["category"] = category.rawValue
        }
        
        if case .all = language {} else {
            parameters["language"] = language.rawValue
        }
        
        if case .all = country {} else {
            parameters["country"] = country.rawValue
        }
        
        if let pageSize = pageSize {
            parameters["pageSize"] = String(pageSize)
        }
        
        if let page = page {
            parameters["page"] = String(page)
        }
        
        return parameters
    }
}

private extension NewsAPITarget {
    func makeSourceEndpoint(baseUrl: String, path: String, parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(path)") else { return nil }
        
        urlComponents.queryItems = parameters.map { name, value in
            return URLQueryItem(name: name, value: value)
        }
        
        return urlComponents.url
    }
}
