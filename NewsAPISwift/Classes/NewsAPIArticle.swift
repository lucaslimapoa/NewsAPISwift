//
//  NewsAPIArticle.swift
//  Pods
//
//  Created by lucas lima on 6/3/17.
//
//

import Foundation

public struct NewsAPIArticle {
    public let author: String?
    public let title: String?
    public let articleDescription: String?
    public let url: URL?
    public let urlToImage: URL?
    public let publishedAt: String?
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
