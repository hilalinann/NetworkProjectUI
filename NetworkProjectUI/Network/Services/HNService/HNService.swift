//
//  HNService.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 27.08.2025.
//

import Foundation

protocol HNServicesProtocol: Sendable {
    func fetchStoryIds() async -> Result<[Int], NetworkError>
    func fetchStoryDetail(storyId: Int) async -> Result<HackerNews, NetworkError>

}

final class HNServices: HNServicesProtocol {
    
    //MARK: - Client
    private let client: ClientProtocol
    
    init(client: ClientProtocol = Client()) {
        self.client = client
    }
    
    //MARK: - Services
    func fetchStoryIds() async -> Result<[Int], NetworkError> {
        return await client.fetch(request: HNRequests.bestStories)
    }
       
    func fetchStoryDetail(storyId: Int) async -> Result<HackerNews, NetworkError> {
        return await client.fetch(request: HNRequests.storiesDetail(storyId: storyId))
    }
}
