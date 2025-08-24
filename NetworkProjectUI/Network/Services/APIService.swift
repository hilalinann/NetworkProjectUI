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
            let bestStoriesEndpoint = Endpoint(path: "/v0/beststories.json")
            let storyIds: [Int] = try await httpClient.request(
                request: SimpleRequest(endpoint: bestStoriesEndpoint),
                responseType: [Int].self
            )
            
            let limitedIds = Array(storyIds.prefix(20))
   
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
}
