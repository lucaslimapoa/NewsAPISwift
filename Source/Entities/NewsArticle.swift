//
//  NewsArticle.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 26/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public struct NewsArticle: Equatable, Decodable {
    public struct NewsSource: Equatable, Decodable {
        public let id: String?
        public let name: String
        
        public init(id: String?, name: String) {
            self.id = id
            self.name = name
        }
    }
    
    public let source: NewsSource
    public let author: String?
    public let title: String
    public let articleDescription: String?
    public let url: URL
    public let urlToImage: URL?
    public let publishedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
    }
    
    public init(source: NewsSource, author: String?, title: String, articleDescription: String?, url: URL, urlToImage: URL?, publishedAt: Date) {
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
