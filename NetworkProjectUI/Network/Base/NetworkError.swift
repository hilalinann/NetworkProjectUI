//
//  NetworkError.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 24.08.2025.
//

import Foundation

public struct NetworkError: Error {
    public let type: NetworkErrorType
    public let message: String
    
    public init(type: NetworkErrorType, message: String) {
        self.type = type
        self.message = message
    }
}

// MARK: - User Facing Description
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        return message
    }
}

public enum NetworkErrorType: Int, Sendable {
    
    /// - badRequest: The server cannot or will not process the request due to an apparent client error.
    case badRequest = 400
    
    /// - notFound: The requested resource could not be found but may be available in the future.
    case notFound = 404
    
    /// - noResponse: Used to indicate that the server has returned no information to the client and closed the connection.
    case noResponse = 444
    
    case decodingFailed
    
    case unknown
   
}

// MARK: - DecodingErrorHandling
extension NetworkError {
    
    static func handleDecodingError(error: DecodingError) -> NetworkError {
            switch error {
            case .typeMismatch(let type, let context):
                debugPrint("Type \(type) mismatch: \(context.debugDescription)")
                debugPrint("codingPath: \(context.codingPath)")
                
            case .valueNotFound(_, let context):
                debugPrint("Value Not Found: \(context.debugDescription)")
                
            case .keyNotFound(let codingKey, let context):
                debugPrint("Coding Key Not Found: \(context.debugDescription)")
                debugPrint("codingKey: \(codingKey)")
                
            case .dataCorrupted(let context):
                debugPrint("Data Corrupted: \(context.debugDescription)")
                debugPrint("underlyingError: \(String(describing: context.underlyingError))")
                
            default:
                debugPrint("Unknown Error: \(error.localizedDescription)")
            }
            
            return NetworkError(type: .decodingFailed, message: error.localizedDescription)
        }
    
}
