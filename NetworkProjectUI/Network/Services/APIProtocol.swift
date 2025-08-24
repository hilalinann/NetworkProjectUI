//
//  APIProtocol.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

protocol APIProtocol {
    func fetchNews() async throws -> [HackerNews]
}
