//
//  PostHunter.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 14/10/2021.
//

import SwiftUI

struct PostHunter: View {

    let post: Post

    var body: some View {
        HStack(alignment: .center) {
            NavigationLink(destination: UserView(id: post.user.id)) {
                ProfileImage(url: post.user.profileImage, size: 36)
                
                VStack(alignment: .leading) {
                    Text("Posted by")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Text(post.user.name)
                        .foregroundColor(.primary)
                        .font(.body)
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
        .padding([.leading, .trailing])
    }
}
