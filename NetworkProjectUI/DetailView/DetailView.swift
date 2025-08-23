//
//  DetailView.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import SwiftUI

struct DetailView: View {
    let news: HackerNews
    
    var body: some View {
        VStack(spacing: 16) {
            Text(news.title)
                .font(.title)
                .bold()
            Text("Yazan: \(news.author)")
            Text("Skor: \(news.score) | Yorum: \(news.commentCount ?? 0)")
            
            if let url = news.url {
                Link("Haberi Oku", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
    }
}


