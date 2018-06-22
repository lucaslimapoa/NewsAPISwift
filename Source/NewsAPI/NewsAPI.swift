//
//  NewsAPIProvider.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public class NewsAPI {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    @discardableResult
    public func request(_ target: NewsAPITarget, completion: @escaping ((Result<[NewsSource], NewsAPIError>) -> ())) -> URLSessionDataTask? {
        guard let url = target.endpoint else {
            completion(.failure(.unknown))
            return nil
        }
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            struct NewsSourceResponse: Decodable {
                let status: String
                let sources: [NewsSource]
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsSourceResponse.self, from: data)
                completion(.success(response.sources))
            } catch {
                completion(.failure(.unknown))
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
