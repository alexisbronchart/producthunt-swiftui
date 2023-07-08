//
//  PostMakers.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 14/10/2021.
//

import SwiftUI

struct PostMakers: View {

    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text("Made by")
                .foregroundColor(.secondary)
                .font(.footnote)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(post.makers) { maker in
                        NavigationLink(destination: UserView(id: maker.id)) {
                            VStack {
                                AsyncImage(url: URL(string: maker.profileImage ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 48, height: 48)
                                .cornerRadius(24)
                                Text(maker.name)
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                Text("@\(maker.username)")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing])
    }
}
