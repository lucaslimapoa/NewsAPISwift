//
//  TargetType.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

protocol TargetType {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
}
