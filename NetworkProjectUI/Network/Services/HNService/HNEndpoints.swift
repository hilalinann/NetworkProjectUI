//
//  HNEndpoints.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 26.08.2025.
//

import Foundation

//MARK: - Endpoints
enum HNEndpoint: EndpointProtocol {
    case bestStories
    case storiesDetail(storyId: Int)
    
    var baseURL: String {
        return "hacker-news.firebaseio.com"
    }
    
    var path: String {
        switch self {
        case .bestStories: return "v0/beststories.json"
        case .storiesDetail(let storyId): return "v0/item/\(storyId).json"
        }
    }
}

//MARK: - Requests
enum HNRequests: Request {
    case bestStories
    case storiesDetail(storyId: Int)
    
    var endpoint: EndpointProtocol {
        switch self {
        case .bestStories: return HNEndpoint.bestStories
        case .storiesDetail(let storyId): return HNEndpoint.storiesDetail(storyId: storyId)
        }
    }
}
