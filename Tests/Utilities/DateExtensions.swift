//
//  DateExtensions.swift
//  Tests
//
//  Created by Lucas Lima on 26/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var iso8601: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter
    }
    
    static var iso8601mm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        
        return dateFormatter
    }
}
