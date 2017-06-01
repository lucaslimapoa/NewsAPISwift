//
//  URLSessionProtocol.swift
//  Pods
//
//  Created by Lucas on 30/05/17.
//
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
typealias JSONTaskResult = ([String: Any]?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping JSONTaskResult) -> URLSessionDataTask
}

extension URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping JSONTaskResult) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, NewsAPIError.invalidData)
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                completionHandler(jsonObject, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
}

extension URLSession: URLSessionProtocol { }
