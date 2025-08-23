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
    
    private let service: APIProtocol = APIService()
    
    func fetchBestStories() {
        Task {
            do {
                let news = try await service.fetchNews()
                self.newsList = news.sorted(by: { $0.score > $1.score })
            } catch {
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
