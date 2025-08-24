//
//  Extension.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 23.08.2025.
//

import Foundation

extension Int {
    func timeAgoDisplay() -> String {
        let now = Date()
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.localizedString(for: date, relativeTo: now)
    }
}

extension URL {
    func hostName() -> String {
        self.host ?? self.absoluteString
    }
}
