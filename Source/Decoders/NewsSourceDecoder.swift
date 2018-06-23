//
//  NewsSourceDecoder.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

class NewsSourceDecoder {
    func decode(data: Data) throws -> [NewsSource] {
        let response = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
        
        if let sources = response?.sources {
            return sources
        }
        
        if let code = response?.code, let message = response?.message {
            throw NewsAPIError.serviceError(code: code, message: message)
        }
        
        throw NewsAPIError.unableToParse
    }
}

private extension NewsSourceDecoder {
    struct NewsSourceResponse: Decodable {
        let status: String
        let code: String?
        let message: String?
        let sources: [NewsSource]?
    }
}
