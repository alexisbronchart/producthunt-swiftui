//
//  WindowBoundsView.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 09/07/2023.
//

import SwiftUI

struct WindowBoundsView: View {

    @Environment(\.windowBounds) var windowBounds

    var body: some View {
        Text("window bounds : \(windowBounds.debugDescription)")
    }
}

#Preview {
    WindowBoundsView()
}
