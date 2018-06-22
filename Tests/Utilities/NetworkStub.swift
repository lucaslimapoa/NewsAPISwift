//
//  NetworkStub.swift
//  Tests
//
//  Created by Lucas Lima on 22/06/18.
//  Copyright © 2018 Lucas Lima. All rights reserved.
//

import Foundation
import OHHTTPStubs

struct NetworkStub {
    static func installSuccessfulRequest(data: Data) {
        stub(condition: isHost("newsapi.org")) { _ in
            return OHHTTPStubsResponse(data: data,
                                       statusCode: 200,
                                       headers: ["Content-Type":"application/json"])
        }
    }
    
    static func installFailureRequest() {
        stub(condition: isHost("newsapi.org")) { _ in
            return OHHTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil))
        }
    }
}
