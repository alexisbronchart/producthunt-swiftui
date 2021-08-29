//
//  URL.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 20/09/2021.
//

import Foundation

extension URL {
    var queryParams: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return [:]
        }
        return queryItems.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
    }
}
