//
//  Result.swift
//  NewsAPISwift
//
//  Created by Lucas Lima on 21/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

public enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
