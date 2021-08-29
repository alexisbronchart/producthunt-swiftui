//
//  ProductHuntSwiftUIApp.swift
//  Shared
//
//  Created by Alexis Bronchart on 29/08/2021.
//

import SwiftUI

@main
struct ProductHuntSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ConfigProvider())
        }
    }
}
