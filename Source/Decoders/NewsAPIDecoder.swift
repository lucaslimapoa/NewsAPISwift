//
//  NewsSourceDecoder.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

class NewsAPIDecoder {
    lazy private var iso8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter
    }()
    
    lazy private var iso8601mm: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        
        return dateFormatter
    }()
    
    func decode<T: Decodable>(data: Data) throws -> [T] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = makeDateDecodingStategy()
        
        let response = try? jsonDecoder.decode(NewsResponse.self, from: data)
        
        if let code = response?.code, let message = response?.message {
            throw NewsAPIError.serviceError(code: code, message: message)
        }
        
        if let sources = response?.sources as? [T] {
            return sources
        }
        
        if let articles = response?.articles as? [T] {
            return articles
        }
        
        throw NewsAPIError.unableToParse
    }
}

private extension NewsAPIDecoder {
    func makeDateDecodingStategy() -> JSONDecoder.DateDecodingStrategy {
        return .custom ({ [weak self] decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            if let date = self?.iso8601.date(from: dateStr) {
                return date
            }
            
            if let date = self?.iso8601mm.date(from: dateStr) {
                return date
            }
            
            throw NewsAPIError.unableToParse
        })
    }
}

private struct NewsResponse: Decodable {
    let status: String
    let code: String?
    let message: String?
    let sources: [NewsSource]?
    let articles: [NewsArticle]?
}
