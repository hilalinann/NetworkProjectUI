//
//  UserManager.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation
import Combine

class UserManager: ObservableObject {
    @Published var currentUser: User?
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchUserProfile(userId: Int) async throws -> UserProfile {
        isLoading = true
        defer { isLoading = false }
        
        let endpoint = Endpoint(path: "/v0/user/\(userId).json")
        
        do {
            let profile: UserProfile = try await httpClient.request(endpoint: endpoint)
            await MainActor.run {
                self.userProfile = profile
            }
            return profile
        } catch {
            throw UserError.failedToFetchProfile
        }
    }
    
    func updateUserProfile(_ profile: UserProfile) async throws -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        // Bu örnekte sadece simülasyon yapıyoruz
        // Gerçek uygulamada PUT request atılır
        
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 saniye
        
        await MainActor.run {
            self.userProfile = profile
        }
        
        return true
    }
    
    func deleteUserAccount() async throws -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        // Bu örnekte sadece simülasyon yapıyoruz
        // Gerçek uygulamada DELETE request atılır
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye
        
        await MainActor.run {
            self.currentUser = nil
            self.userProfile = nil
        }
        
        return true
    }
}

enum UserError: Error, LocalizedError {
    case failedToFetchProfile
    case failedToUpdateProfile
    case failedToDeleteAccount
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .failedToFetchProfile:
            return "Kullanıcı profili alınamadı"
        case .failedToUpdateProfile:
            return "Profil güncellenemedi"
        case .failedToDeleteAccount:
            return "Hesap silinemedi"
        case .userNotFound:
            return "Kullanıcı bulunamadı"
        }
    }
}

struct UserProfile: Codable, Identifiable {
    let id: String
    let created: Int
    let karma: Int
    let about: String?
    let submitted: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id, created, karma, about, submitted
    }
}
