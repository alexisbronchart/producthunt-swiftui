//
//  ContentView.swift
//  Shared
//
//  Created by Alexis Bronchart on 29/08/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var configProvider: ConfigProvider

    var body: some View {
        NavigationStack {
            PostsFeedView()
        }
        .accentColor(configProvider.config.theme.accentColor)
        .onAppear {
            configProvider.loadConfig()
        }
    }
}
