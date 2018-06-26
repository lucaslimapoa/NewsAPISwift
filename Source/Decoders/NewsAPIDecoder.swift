//
//  NewsSourceDecoder.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

class NewsAPIDecoder {
    func decode<T: Decodable>(data: Data) throws -> [T] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
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

private struct NewsResponse: Decodable {
    let status: String
    let code: String?
    let message: String?
    let sources: [NewsSource]?
    let articles: [NewsArticle]?
}
