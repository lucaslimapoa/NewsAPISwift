//
//  NewsAPIArticle.swift
//  Pods
//
//  Created by lucas lima on 6/3/17.
//
//

import ObjectMapper

public struct NewsAPIArticle {
    public let author: String?
    public let title: String?
    public let articleDescription: String?
    public let url: URL?
    public let urlToImage: URL?
    public let publishedAt: String?
}

extension NewsAPIArticle: ImmutableMappable {
    public init(map: Map) throws {
        author              = try? map.value("author")
        title               = try? map.value("title")
        articleDescription  = try? map.value("description")
        url                 = try? map.value("url", using: URLTransform())
        urlToImage          = try? map.value("urlToImage", using: URLTransform())
        publishedAt         = try? map.value("publishedAt")
    }
}

extension NewsAPIArticle: Equatable { }

public func ==(lhs: NewsAPIArticle, rhs: NewsAPIArticle) -> Bool {
    return lhs.author == rhs.author
        && lhs.articleDescription == rhs.articleDescription
        && lhs.title == rhs.title
        && lhs.url == rhs.url
        && lhs.urlToImage == rhs.urlToImage
        && lhs.publishedAt == rhs.publishedAt
}
