//
//  EncodableExtension.swift
//  NetworkProjectUI
//
//  Created by Hilal İnan on 26.08.2025.
//

import Foundation

public extension Encodable {
    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
