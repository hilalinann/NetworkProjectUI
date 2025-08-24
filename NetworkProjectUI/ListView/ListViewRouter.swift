//
//  ListViewRouter.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import SwiftUI

class ListViewRouter {
    func view(for route: Route) -> some View {
        switch route {
        case .newsDetail(let news):
            return DetailView(news: news)
        }
    }
}
