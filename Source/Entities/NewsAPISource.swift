//
//  NewsAPISource.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public struct NewsAPISource: Equatable, Decodable {
    public let id: String
    public let name: String
    public let description: String
    public let url: URL
    public let category: NewsAPICategory
    public let language: NewsAPILanguage
    public let country: NewsAPICountry
    
    public init(id: String,
                name: String,
                description: String,
                url: URL,
                category: NewsAPICategory,
                language: NewsAPILanguage,
                country: NewsAPICountry) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
