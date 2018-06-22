//
//  NewsAPISource.swift
//  Pods
//
//  Created by Lucas on 29/05/17.
//
//

import ObjectMapper

public typealias SourceId = String

public struct NewsAPISource {
    public let id: SourceId?
    public let name: String?
    public let sourceDescription: String?
    public let url: String?
    public let category: Category?
    public let language: Language?
    public let country: Country?
    public let sortBysAvailable: [SortBy]
    
    public init(id: SourceId, name: String, sourceDescription: String, url: String, category: Category, language: Language, country: Country, sortBysAvailable: [SortBy] ) {
        self.id = id
        self.name = name
        self.sourceDescription = sourceDescription
        self.url = url
        self.category = category
        self.language = language
        self.country = country
        self.sortBysAvailable = sortBysAvailable
    }
}

extension NewsAPISource: ImmutableMappable {
    public init(map: Map) throws {
        id                  = try? map.value("id")
        name                = try? map.value("name")
        sourceDescription   = try? map.value("description")
        url                 = try? map.value("url")
        category            = try? map.value("category")
        language            = try? map.value("language")
        country             = try? map.value("country")
        
        if let sortBys: [String] = try? map.value("sortBysAvailable") {
            sortBysAvailable = sortBys
                .flatMap { SortBy(rawValue: $0) }
        } else {
            sortBysAvailable = [SortBy]()
        }
    }
}

extension NewsAPISource: Equatable { }

public func ==(lhs: NewsAPISource, rhs: NewsAPISource) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.sourceDescription == rhs.sourceDescription
        && lhs.url == rhs.url
        && lhs.category == rhs.category
        && lhs.language == rhs.language
        && lhs.country == rhs.country
        && lhs.sortBysAvailable == rhs.sortBysAvailable
}
