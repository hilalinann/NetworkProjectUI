//
//  AuthManager.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private let userDefaults = UserDefaults.standard
    private let authKey = "auth_token"
    
    init() {
        checkAuthenticationStatus()
    }
    
    func login(username: String, password: String) async throws -> Bool {
        // Bu örnekte basit bir authentication simülasyonu yapıyoruz
        // Gerçek uygulamada API'ye istek atılır
        
        // Simüle edilmiş gecikme
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye
        
        if username == "demo" && password == "123456" {
            let token = UUID().uuidString
            userDefaults.set(token, forKey: authKey)
            isAuthenticated = true
            currentUser = User(id: 1, username: username, email: "\(username)@example.com")
            return true
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: authKey)
        isAuthenticated = false
        currentUser = nil
    }
    
    private func checkAuthenticationStatus() {
        if let token = userDefaults.string(forKey: authKey), !token.isEmpty {
            isAuthenticated = true
            // Token'dan user bilgilerini çek
            currentUser = User(id: 1, username: "demo", email: "demo@example.com")
        }
    }
}

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case networkError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Kullanıcı adı veya şifre hatalı"
        case .networkError:
            return "Ağ bağlantısı hatası"
        case .serverError:
            return "Sunucu hatası"
        }
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
}
