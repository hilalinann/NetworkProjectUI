//
//  WebService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation
import Combine

protocol APIProtocol {
    func fetchNews() async throws -> [HackerNews]
}


class APIService: APIProtocol {
    
    func fetchNews() async throws -> [HackerNews] {
        let url = NetworkingRouter.bestStories.url
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let ids = try JSONDecoder().decode([Int].self, from: data)
        
        let first20 = Array(ids.prefix(20))
        
        // Her item için request
        var stories: [HackerNews] = []
        
        try await withThrowingTaskGroup(of: HackerNews.self) { group in
            for id in first20 {
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: NetworkingRouter.item(id).url)
                    return try JSONDecoder().decode(HackerNews.self, from: data)
                }
            }
            
            for try await story in group {
                stories.append(story)
            }
        }
        
        return stories
    }
}



enum DownloaderError: Error {
    case invalidURL
    case noData
    case dataParseError
}

extension DownloaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL oluşturulamadı."
        case .noData:
            return "Sunucudan veri alınamadı."
        case .dataParseError:
            return "Veri işlenemedi (JSON decode hatası)."
        }
    }
}
