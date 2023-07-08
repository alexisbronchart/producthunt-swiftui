//
//  PostCell.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 14/10/2021.
//

import SwiftUI

struct PostCell: View {

    let post: PostCellFragment

    var body: some View {
        NavigationLink(destination: PostView(id: self.post.id, title: self.post.name)) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: post.thumbnail?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)

                VStack(alignment: .leading) {
                    Text(post.name)
                        .foregroundColor(.primary)
                        .font(.headline)

                    Text(post.tagline)
                        .foregroundColor(.secondary)
                        .font(.subheadline)

                    Spacer()

                    HStack {
                        AsyncImage(url: URL(string: post.user.profileImage ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 20, height: 20)
                        .cornerRadius(10)
                        Text(post.user.name)
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }

                Spacer()

                VStack {
                    Text("\(post.votesCount)")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    Text("votes")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
            }
            .padding([.top, .bottom], 8)
        }
    }
}
