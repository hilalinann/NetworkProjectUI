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
    
//    var method: HTTPMethod {
//        switch self {
//        case .bestStories, .storiesDetail
//        }
//    }
//    
//    var header: [String : String] {
//        switch self {
//        case .bestStories, .storiesDetail:
//            return APIKeyManager.shared.getAuthorizationHeader() ?? ["Content-Type": "application/json"]
//        }
//    }
//    
//    var body: Encodable? {
//        switch self {
//        case .bestStories(let story):
//            let messages: [[String: String]] = [ ["role": "system", "content": "You are a children's storyteller."], ["role": "user", "content": story] ]
//            return OpenAITextRequestModel( model: "gpt-4o", messages: messages)
//            
//        case .storiesDetail(let story):
//            return OpenAISpeechRequestModel(model: "tts-1", input: story, voice: "nova", format: "mp3")
//        }
//    }
}
