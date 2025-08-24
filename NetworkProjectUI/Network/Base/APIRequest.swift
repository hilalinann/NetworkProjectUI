//
//  APIRequest.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

struct APIRequest<T: Encodable> {
    let endpoint: Endpoint
    let body: T?
    
    init(endpoint: Endpoint, body: T? = nil) {
        self.endpoint = endpoint
        self.body = body
    }
    
    var urlRequest: URLRequest? {
        
        guard let url = URL(string: "https://hacker-news.firebaseio.com" + endpoint.path) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return nil
            }
        }
        
        return request
    }
}
