//
//  PostsFeedPresenter.swift
//  PostsFeedPresenter
//
//  Created by Alexis Bronchart on 01/09/2021.
//

import Foundation
import Apollo

typealias PostConnection = PostsFeedQuery.Data.Post
typealias PostNode = PostsFeedQuery.Data.Post.Edge.Node

extension PostNode: Identifiable {}

enum PostsFeedState {
    case empty
    case loading
    case posts(posts: [PostNode], hasMore: Bool, isLoadingMore: Bool)
    case error(_: Error)
}

class PostsFeedPresenter: ObservableObject {

    // MARK: Publishers

    @Published var postsFeedState: PostsFeedState = .empty

    // MARK: Internal stuff

    private var lastConnection: PostConnection?
    private var posts: [PostNode] = []
    private var currentQuery: Cancellable?

    private func loadPosts(from cursor: String?, reload: Bool) {
        if self.posts.count == 0 {
            self.postsFeedState = PostsFeedState.loading
        } else {
            self.postsFeedState = PostsFeedState.posts(posts: self.posts, hasMore: true, isLoadingMore: true)
        }

        self.currentQuery = Network.instance.client.fetch(query: PostsFeedQuery(count: 10, cursor: cursor)) { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let graphQLResult):
                if let postsConnection = graphQLResult.data?.posts {
                    let posts = postsConnection.edges.compactMap({ $0.node })
                    let hasMore = postsConnection.pageInfo.hasNextPage

                    // update connection
                    self.lastConnection = postsConnection

                    // if first load, init state
                    if cursor == nil {
                        self.posts = posts
                        self.postsFeedState = PostsFeedState.posts(posts: posts, hasMore: hasMore, isLoadingMore: false)
                    } else {
                        var existingPosts = self.posts
                        existingPosts.append(contentsOf: posts)
                        self.posts = existingPosts
                        self.postsFeedState = PostsFeedState.posts(posts: existingPosts, hasMore: hasMore, isLoadingMore: false)
                    }

                } else {
                    self.postsFeedState = PostsFeedState.error(PHError.noResult)
                }

            case .failure(let error):
                print("Error loading data \(error)")
                self.lastConnection = nil
                self.posts = []
                self.postsFeedState = PostsFeedState.error(error)
            }

            self.currentQuery = nil
        }
    }

    // MARK: Functions

    func loadMore() {
        if case .loading = self.postsFeedState, self.currentQuery != nil {
            return
        }

        if case let .posts(_, _, isLoadingMore) = self.postsFeedState {
            if isLoadingMore {
                return
            }
        }

        guard let connection = self.lastConnection else {
            self.loadPosts(from: nil, reload: false)
            return
        }

        if !connection.pageInfo.hasNextPage {
            return
        }

        self.loadPosts(from: connection.pageInfo.endCursor, reload: false)
    }

    func reload() {
        self.currentQuery?.cancel()
        self.loadPosts(from: nil, reload: true)
    }
}
