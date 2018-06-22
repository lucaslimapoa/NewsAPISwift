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
    public let description: String
    public let url: URL
    public let category: NewsCategory
    public let language: NewsLanguage
    public let country: NewsCountry
    
    public init(id: String,
                name: String,
                description: String,
                url: URL,
                category: NewsCategory,
                language: NewsLanguage,
                country: NewsCountry) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}