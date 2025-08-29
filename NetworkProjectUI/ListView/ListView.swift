//
//  ContentView.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.newsList) { news in
                NavigationLink(value: Route.newsDetail(news)) {
                    Entry(story: news)
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Hacker News")
            .onAppear {
                viewModel.fetchStories()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Hata"), message: Text(error.message), dismissButton: .default(Text("Tamam")))
            }
            .navigationDestination(for: Route.self) { route in
                ListViewRouter().view(for: route)
            }
        }
    }
}

extension Entry {
    init(story: HackerNews) {
        self.title = story.title
        self.score = story.score
        self.commentCount = story.commentCount ?? 0
        self.author = story.author
        
        let host = story.url?.hostName() ?? ""
        let date = story.date?.timeAgoDisplay() ?? ""
        self.footnote = "\(host) – \(date) – by \(story.author)"
    }
}
