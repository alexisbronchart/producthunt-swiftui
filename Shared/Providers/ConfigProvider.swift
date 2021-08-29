//
//  ConfigProvider.swift
//  ConfigProvider
//
//  Created by Alexis Bronchart on 13/09/2021.
//

import Foundation
import Apollo
import SwiftUI

struct Config {
    let auth: Auth
    let theme: Theme

    struct Theme {
        let accentColor: Color
    }

    struct Auth {
        let accessToken: String?
        let isLoggedIn: Bool
    }

    static var instance: Config?
}

class ConfigProvider: ObservableObject {

    // MARK: Constants

    private struct Defaults {
        static let accentColor = Color.orange
        static let accessToken = ""
    }

    // MARK: Publishers

    @Published var config = Config(auth: Config.Auth(accessToken: nil, isLoggedIn: false), theme: Config.Theme(accentColor: Defaults.accentColor))

    // MARK: Loading content

    func loadConfig() {
        self.config = Config(auth: Config.Auth(accessToken: Defaults.accessToken, isLoggedIn: true), theme: Config.Theme(accentColor: Defaults.accentColor))
        Config.instance = self.config
    }
}
