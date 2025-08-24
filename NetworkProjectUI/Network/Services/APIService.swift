//
//  APIService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

class APIService: APIProtocol {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchNews() async throws -> [HackerNews] {
        // Önce en iyi story ID'lerini al
        let bestStoriesEndpoint = Endpoint(path: "/v0/beststories.json")
        let storyIds: [Int] = try await httpClient.request(endpoint: bestStoriesEndpoint)
        
        // İlk 20 story'yi al (performans için)
        let limitedIds = Array(storyIds.prefix(20))
        
        // Her story için detay bilgilerini al
        var stories: [HackerNews] = []
        
        for storyId in limitedIds {
            let storyEndpoint = Endpoint(path: "/v0/item/\(storyId).json")
            let story: HackerNews = try await httpClient.request(endpoint: storyEndpoint)
            stories.append(story)
        }
        
        return stories
    }
}
