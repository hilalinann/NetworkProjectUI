//
//  APIRequest.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

public protocol Request {
    var endpoint: Endpoint { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
}

public extension Request {
    var method: HTTPMethod { .GET }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
}

public extension Request {
    
    func buildURLRequest() -> URLRequest? {
        
        guard let url = endpoint.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                return nil
            }
        }
        
        return urlRequest
    }
}

