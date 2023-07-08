//
//  PostHeading.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 14/10/2021.
//

import SwiftUI

struct PostHeading: View {

    let post: Post

    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: post.thumbnail?.url ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(post.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(post.tagline)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
