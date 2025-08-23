//
//  ListViewRouter.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation
import SwiftUI

struct ListViewRouter {
    func view(for route: Route) -> some View {
        switch route {
        case .newsDetail(let news):
            return AnyView(DetailView(news: news))
        }
    }
}

let router = ListViewRouter()
