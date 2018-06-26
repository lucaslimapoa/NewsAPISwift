//
//  NewsAPISource.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public struct NewsSource: Equatable, Decodable {
    public let id: String
    public let name: String
    public let sourceDescription: String
    public let url: URL
    public let category: NewsCategory
    public let language: NewsLanguage
    public let country: NewsCountry
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sourceDescription = "description"
        case url
        case category
        case language
        case country
    }
    
    public init(id: String,
                name: String,
                sourceDescription: String,
                url: URL,
                category: NewsCategory,
                language: NewsLanguage,
                country: NewsCountry) {
        self.id = id
        self.name = name
        self.sourceDescription = sourceDescription
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
