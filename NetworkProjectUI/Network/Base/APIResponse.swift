//
//  APIResponse.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

struct APIResponse<T: Decodable> {
    let data: T
    let statusCode: Int
    let headers: [String: String]
    
    init(data: T, statusCode: Int, headers: [String: String]) {
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
    }
}

// Hata durumları için response wrapper
struct ErrorResponse: Decodable {
    let error: String
    let message: String?
    let statusCode: Int?
}
