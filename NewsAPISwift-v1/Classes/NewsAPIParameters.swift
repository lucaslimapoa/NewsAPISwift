//
//  NewsAPIParameters.swift
//  Pods
//
//  Created by Lucas on 30/05/17.
//
//

public enum Category: String {
    case business = "business"
    case entertainment = "entertainment"
    case gaming = "gaming"
    case general = "general"
    case music = "music"
    case politics = "politics"
    case scienceAndNature = "science-and-nature"
    case sport = "sport"
    case technology = "technology"
}

public enum Language: String {
    case english = "en"
    case deutsch = "de"
    case french = "fe"
}

public enum Country: String {
    case australia = "au"
    case germany = "de"
    case unitedKingdom = "gb"
    case india = "in"
    case italy = "it"
    case unitedStates = "us"
}

public enum SortBy: String {
    case top = "top"
    case latest = "latest"
    case popular = "popular"
}
