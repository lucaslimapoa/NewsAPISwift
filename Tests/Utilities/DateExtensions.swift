//
//  DateExtensions.swift
//  Tests
//
//  Created by Lucas Lima on 26/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

extension Date {
    init(string: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds]
        
        self = formatter.date(from: string)!
    }
}
