//
//  APIService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

//class APIService: APIProtocol {
//    
//    private let httpClient: Client
//    
//    init(httpClient: Client = Client()) {
//        self.httpClient = httpClient
//    }
//    
//    func fetchNews() async throws -> [HackerNews] {
//            let bestStoriesEndpoint = Endpoint(path: "/v0/beststories.json")
//            let storyIds: [Int] = try await httpClient.request(
//                request: SimpleRequest(endpoint: bestStoriesEndpoint),
//                responseType: [Int].self
//            )
//            
//            let limitedIds = Array(storyIds.prefix(20))
//   
//            var stories: [HackerNews] = []
//            
//            for storyId in limitedIds {
//                let storyEndpoint = Endpoint(path: "/v0/item/\(storyId).json")
//                let story: HackerNews = try await httpClient.request(
//                    request: SimpleRequest(endpoint: storyEndpoint),
//                    responseType: HackerNews.self
//                )
//                stories.append(story)
//            }
//            
//            return stories
//        }
//}

protocol HNServicesProtocol: Sendable {
    func fetchNews<T: Decodable>(request: Request) async -> Result<T, NetworkError>
    func fetchTopStories() async -> Result<[HackerNews], NetworkError>
}

final class HNServices: HNServicesProtocol {
    func fetchNews<T>(request: any Request) async -> Result<T, NetworkError> where T : Decodable {
        return await client.fetch(request: request)
    }
    
    
    //MARK: - Client
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    //MARK: - Services
//    func fetchNews<T>(request: Request) async -> Result<T, NetworkError> {
////        let result: Result<T, NetworkError> = await client.fetch(request: request, T.self)
////        return result
//        return await client.fetch(request: request)
//    }
    
    func fetchTopStories() async -> Result<[HackerNews], NetworkError> {
        // Top story ID'leri
        let topStoriesResult: Result<[Int], NetworkError> = await fetchNews(request: HNRequests.bestStories)
        
        switch topStoriesResult {
        case .failure(let error):
            return .failure(error)
        case .success(let storyIds):
            let limitedIds = Array(storyIds.prefix(20))
            var stories: [HackerNews] = []
            
            for storyId in limitedIds {
                let detailResult: Result<HackerNews, NetworkError> = await fetchNews(request: HNRequests.storiesDetail(storyId: storyId))
                
                switch detailResult {
                case .success(let story):
                    stories.append(story)
                case .failure(let error):
                    print("Story \(storyId) yüklenirken hata: \(error)")
                }
            }
            
            return .success(stories)
        }
    }
}
