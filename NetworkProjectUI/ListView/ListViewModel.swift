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
    
    private func fetchStoriesDetail(from ids: [Int]) async -> [HackerNews] {
        var stories: [HackerNews] = []
        
        for id in ids {
            do {
                let story = try await service.fetchStoryDetail(storyId: id).get()
                stories.append(story)
            } catch {
                print("Story \(id) yüklenirken hata: \(error)")
            }
        }
        return stories
    }
    
    private func fetchTopStoryIds(limit: Int = 20) async throws -> [Int] {
        let storyIds = try await service.fetchStoryIds().get()
        return Array(storyIds.prefix(limit))
    }
    
    func fetchStories() {
        Task {
            do {
                let limitedIds = try await fetchTopStoryIds()
                let stories = await fetchStoriesDetail(from: limitedIds)
                self.newsList = stories.sorted(by: { $0.score > $1.score })
            } catch {
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
