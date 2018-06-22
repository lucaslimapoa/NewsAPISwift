//
//  NewsAPITarget.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

protocol TargetType {
    var baseUrl: String { get }
    var path: String { get }
}

public enum NewsAPICategory {
    case all
}

public enum NewsAPILanguage {
    case all
}

public enum NewsAPICountry {
    case all
}

public enum NewsAPITarget {
    case sources(category: NewsAPICategory, language: NewsAPILanguage, country: NewsAPICountry)
}

extension NewsAPITarget: TargetType {
    var baseUrl: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .sources(_, _, _):
            return ""
        }
    }
}
