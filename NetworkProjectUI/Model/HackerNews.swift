//
//  HackerNews.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

struct HackerNews: Hashable, Identifiable, Decodable {
    let id: Int
    let commentCount: Int?
    let score: Int
    let author: String
    let title: String
    let date: Int?
    let url: URL?

    enum CodingKeys: String, CodingKey {
        case id, score, title, url
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
    }
}


