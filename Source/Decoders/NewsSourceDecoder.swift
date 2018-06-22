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
        let sources: [NewsSource]
        
        do {
            let response = try JSONDecoder().decode(NewsSourceResponse.self, from: data)
            sources = response.sources
        } catch {
            throw NewsAPIError.unableToParse
        }
        
        return sources
    }
}

private extension NewsSourceDecoder {
    struct NewsSourceResponse: Decodable {
        let status: String
        let sources: [NewsSource]
    }
}
