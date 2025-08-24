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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(news.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack {
                    Label("\(news.score)", systemImage: "arrow.up")
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    Label("\(news.commentCount ?? 0)", systemImage: "message")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                HStack {
                    Label(news.author, systemImage: "person")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let date = news.date {
                        Label(date.timeAgoDisplay(), systemImage: "clock")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                if let url = news.url {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "link")
                            Text(url.absoluteString)
                                .lineLimit(2)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Haber Detayı")
        .navigationBarTitleDisplayMode(.inline)
    }
}


