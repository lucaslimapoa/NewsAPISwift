//
//  NewsAPIResult.swift
//  Pods
//
//  Created by lucas lima on 6/1/17.
//
//

public enum Result<T> {
    case error(Error)
    case success(T)
}

public enum NewsAPIError: Error {
    case invalidUrl
    case invalidData
    case cannotParseData
    case statusCode(Int)
}
