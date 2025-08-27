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
    
    func fetchBestStories() {
        Task {
            do {
                let result = await service.fetchTopStories()
                switch result {
                case .success(let stories):
                    self.newsList = stories.sorted(by: { $0.score > $1.score })
                case .failure(let error):
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            } catch {
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
