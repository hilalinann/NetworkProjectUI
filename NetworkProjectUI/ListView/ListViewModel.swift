//
//  ListViewModel.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation
import Combine

@MainActor
class ListViewModel: ObservableObject {
    
    @Published var newsList: [HackerNews] = []
    
    struct ErrorMessage: Identifiable {
        var id: String { message }
        let message: String
    }

    @Published var errorMessage: ErrorMessage?
    
    private let service: HNServicesProtocol = HNServices()
    
    func fetchStoryIds() async -> Result<[Int], NetworkError> {
        return await service.fetchNews(request: HNRequests.bestStories)
    }
    
    func fetchStoryDetail(storyId: Int) async -> Result<HackerNews, NetworkError> {
        return await service.fetchNews(request: HNRequests.storiesDetail(storyId: storyId))
    }
    
    func fetchBestStories() {
        Task {
            let idsResult = await fetchStoryIds()
            
            switch idsResult {
            case .failure(let error):
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
                
            case .success(let storyIds):
                let limitedIds = Array(storyIds.prefix(20))
                var stories: [HackerNews] = []
                    
                for id in limitedIds {
                    let detailResult = await fetchStoryDetail(storyId: id)
                    switch detailResult {
                    case .success(let story):
                        stories.append(story)
                    case .failure(let error):
                        print("Story \(id) yüklenirken hata: \(error)")
                    }
                }
                    
                self.newsList = stories.sorted(by: { $0.score > $1.score })
            }
        }
    }
        
        
//    func fetchBestStories() {
//        Task {
//            let result = await service.fetchBestStories()
//            switch result {
//            case .success(let stories):
//                self.newsList = stories.sorted(by: { $0.score > $1.score })
//            case .failure(let error):
//                self.errorMessage = ErrorMessage(message: error.localizedDescription)
//            }
//        }
//    }
}
