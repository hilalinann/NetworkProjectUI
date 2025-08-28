//
//  HNService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 27.08.2025.
//

import Foundation

protocol HNServicesProtocol: Sendable {
    func fetchNews<T: Decodable>(request: Request) async -> Result<T, NetworkError>
    //func fetchBestStories() async -> Result<[HackerNews], NetworkError>
}

final class HNServices: HNServicesProtocol {
    
    //MARK: - Client
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    //MARK: - Services
    func fetchNews<T>(request: any Request) async -> Result<T, NetworkError> where T : Decodable {
        return await client.fetch(request: request)
    }
    
//    func fetchBestStories() async -> Result<[HackerNews], NetworkError> {
//        
//        let topStoriesResult: Result<[Int], NetworkError> = await fetchNews(request: HNRequests.bestStories)
//        
//        switch topStoriesResult {
//        case .failure(let error):
//            return .failure(error)
//        case .success(let storyIds):
//            let limitedIds = Array(storyIds.prefix(20))
//            var stories: [HackerNews] = []
//            
//            for storyId in limitedIds {
//                let detailResult: Result<HackerNews, NetworkError> = await fetchNews(request: HNRequests.storiesDetail(storyId: storyId))
//                
//                switch detailResult {
//                case .success(let story):
//                    stories.append(story)
//                case .failure(let error):
//                    print("Story \(storyId) yüklenirken hata: \(error)")
//                }
//            }
//            
//            return .success(stories)
//        }
//    }
}
