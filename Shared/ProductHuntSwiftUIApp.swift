//
//  ProductHuntSwiftUIApp.swift
//  Shared
//
//  Created by Alexis Bronchart on 29/08/2021.
//

import SwiftUI

@main
struct ProductHuntSwiftUIApp: App {

    let configProvider = ConfigProvider()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(configProvider)
                .provideScreenBounds()
        }
    }
}
