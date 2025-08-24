//
//  APIService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

class APIService: APIProtocol {
    
    private let httpClient: Client
    
    init(httpClient: Client = Client()) {
        self.httpClient = httpClient
    }
    
    func fetchNews() async throws -> [HackerNews] {
            // Önce en iyi story ID'lerini al
            let bestStoriesEndpoint = Endpoint(path: "/v0/beststories.json")
            let storyIds: [Int] = try await httpClient.request(
                request: SimpleRequest(endpoint: bestStoriesEndpoint),
                responseType: [Int].self
            )
            
            // İlk 20 story'yi al (performans için)
            let limitedIds = Array(storyIds.prefix(20))
            
            // Her story için detay bilgilerini al
            var stories: [HackerNews] = []
            
            for storyId in limitedIds {
                let storyEndpoint = Endpoint(path: "/v0/item/\(storyId).json")
                let story: HackerNews = try await httpClient.request(
                    request: SimpleRequest(endpoint: storyEndpoint),
                    responseType: HackerNews.self
                )
                stories.append(story)
            }
            
            return stories
        }
    
//    func fetchNews() async throws -> [HackerNews] {
//        // Önce en iyi story ID'lerini al
//        let bestStoriesEndpoint = Endpoint(path: "/v0/beststories.json")
//        let bestStoriesRequest = APIRequest<EmptyBody>(endpoint: bestStoriesEndpoint)
//        let storyIds: [Int] = try await httpClient.request(request: bestStoriesRequest, responseType: [Int].self)
//        
//        // İlk 20 story'yi al (performans için)
//        let limitedIds = Array(storyIds.prefix(20))
//        
//        // Her story için detay bilgilerini al
//        var stories: [HackerNews] = []
//        
//        for storyId in limitedIds {
//            let storyEndpoint = Endpoint(path: "/v0/item/\(storyId).json")
//            let storyRequest = APIRequest<EmptyBody>(endpoint: storyEndpoint)
//            
//            let story: HackerNews = try await httpClient.request(request: storyRequest, responseType: HackerNews.self)
//            stories.append(story)
//        }
//        
//        return stories
//    }
}
