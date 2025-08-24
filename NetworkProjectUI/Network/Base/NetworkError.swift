//
//  NetworkError.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 24.08.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .invalidResponse:
            return "Geçersiz yanıt"
        case .httpError(let statusCode):
            return "HTTP hatası: \(statusCode)"
        case .decodingError(let error):
            return "Veri çözümleme hatası: \(error.localizedDescription)"
        }
    }
}
