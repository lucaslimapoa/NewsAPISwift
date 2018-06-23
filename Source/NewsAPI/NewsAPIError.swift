//
//  NewsAPIError.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public enum NewsAPIError: Error {
    case unknown
    case unableToParse
    case requestFailed
    case invalidEndpointUrl
    case serviceError(code: String, message: String)
}
