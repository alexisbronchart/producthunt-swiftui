//
//  PostsFeedView.swift
//  PostsFeedView
//
//  Created by Alexis Bronchart on 01/09/2021.
//

import SwiftUI

struct PostCell: View {

    let post: PostNode

    var body: some View {
        NavigationLink(destination: PostView(id: self.post.id, title: self.post.name)) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: post.thumbnail?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .cornerRadius(4)
                VStack(alignment: .leading) {
                    Text(post.name)
                        .foregroundColor(.primary)
                        .font(.headline)
                    Text(post.tagline)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            .padding([.top, .bottom], 8)
        }
    }
}

struct PostsFeedView: View {

    @StateObject var presenter = PostsFeedPresenter()

    var body: some View {
        VStack {
            switch self.presenter.postsFeedState {
            case .error(let error):
                VStack {
                    Text("⚠️")
                        .font(.system(size: 50))
                        .padding()
                    Text("Sorry, an error occurred! \(error.localizedDescription)")
                }
                .padding()
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .posts(let posts, let hasMore, let isLoadingMore):
                List {
                    Section {
                        ForEach(posts) { post in
                            PostCell(post: post)
                        }
                    }

                    LoadMore(hasMore: hasMore, isLoadingMore: isLoadingMore) {
                        self.loadPosts()
                    }
                    .frame(maxWidth: .infinity)
                    .listSectionSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            case .empty:
                Spacer()
            }
        }
        .navigationBarTitle("Products")
        .refreshable {
            self.presenter.reload()
        }
        .onAppear() {
            self.loadPosts()
        }
    }

    func loadPosts() {
        self.presenter.loadMore()
    }
}
