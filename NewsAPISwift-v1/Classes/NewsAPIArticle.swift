//
//  NewsAPIArticle.swift
//  Pods
//
//  Created by lucas lima on 6/3/17.
//
//

import ObjectMapper

public struct NewsAPIArticle {
    public var sourceId: SourceId?
    public let author: String?
    public let title: String?
    public let articleDescription: String?
    public let url: URL?
    public let urlToImage: URL?
    public var publishedAt: String?
    
    public init(sourceId: SourceId?, author: String?, title: String?, articleDescription: String?, url: URL?, urlToImage: URL?, publishedAt: String?) {
        self.sourceId = sourceId
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}

extension NewsAPIArticle: ImmutableMappable {
    public init(map: Map) throws {
        author              = try? map.value("author")
        title               = try? map.value("title")
        articleDescription  = try? map.value("description")
        url                 = try? map.value("url", using: URLTransform())
        publishedAt         = try? map.value("publishedAt")
        
        if let imageURL: String = try? map.value("urlToImage") {
            urlToImage = URL(string: imageURL)
        } else {
            urlToImage = nil
        }
    }
}

extension NewsAPIArticle: Equatable { }

public func ==(lhs: NewsAPIArticle, rhs: NewsAPIArticle) -> Bool {
    return lhs.sourceId == rhs.sourceId
        && lhs.author == rhs.author
        && lhs.articleDescription == rhs.articleDescription
        && lhs.title == rhs.title
        && lhs.url == rhs.url
        && lhs.urlToImage == rhs.urlToImage
        && lhs.publishedAt == rhs.publishedAt
}
