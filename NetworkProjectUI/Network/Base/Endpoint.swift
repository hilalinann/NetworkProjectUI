//
//  Endpoint.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
    
    init(
        path: String,
        method: HTTPMethod = .GET,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
}
