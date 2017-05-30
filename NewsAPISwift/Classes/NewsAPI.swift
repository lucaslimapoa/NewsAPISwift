//
//  NewsAPI.swift
//  Pods
//
//  Created by Lucas on 29/05/17.
//
//

public enum Category: String {
    case business = "business"
    case entertainment = "entertainment"
    case gaming = "gaming"
    case general = "general"
    case music = "music"
    case politics = "politics"
    case scienceAndNature = "science-and-nature"
    case sport = "sport"
    case technology = "technology"
}

public enum Language: String {
    case english = "en"
    case deutsch = "de"
    case french = "fe"
}

public enum Country: String {
    case australia = "au"
    case germany = "de"
    case unitedKingdom = "gb"
    case india = "in"
    case italy = "it"
    case unitedStates = "us"
}

public enum NewsAPIError: Error {
    
}

public enum NewsAPIResponse {
    
}

public class NewsAPI {
    
    private let key: String
    
    private let sourcesEndpoint = "https://newsapi.org/v1/sources"
    private let articlesEndpoint = "https://newsapi.org/v1/articles"
    
    init(key: String) {
        self.key = key
    }
    
    public func getSources(category: Category? = nil, language: Language? = nil, country: Country? = nil, completionHandler: @escaping ([NewsAPISource]?, NewsAPIError?, NewsAPIResponse) -> Void) {
        
    }
    
}
