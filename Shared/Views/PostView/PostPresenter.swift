//
//  PostPresenter.swift
//  PostPresenter
//
//  Created by Alexis Bronchart on 01/09/2021.
//

import Foundation
import Apollo

// MARK: Types

typealias Post = PostQuery.Data.Post
typealias Media = PostQuery.Data.Post.Medium
typealias Maker = PostQuery.Data.Post.Maker

extension Media: Identifiable {}
extension Maker: Identifiable {}

enum PostState {
    case empty
    case loading
    case post(post: Post)
    case error(_: Error)
}

// MARK: Presenter

class PostPresenter: ObservableObject {

    // MARK: Publishers

    @Published var postState: PostState = .empty

    // MARK: Properties

    private var lastConnection: PostConnection?
    private var post: Post?
    private var currentQuery: Cancellable?

    // MARK: Functions

    func loadPost(id: String) {
        if let post = self.post {
            self.postState = PostState.post(post: post)
        } else {
            self.postState = PostState.loading
        }

        self.currentQuery = Network.instance.client.fetch(query: PostQuery(id: id)) { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let graphQLResult):
                if let post = graphQLResult.data?.post {
                    self.post = post
                    self.postState = PostState.post(post: post)
                } else {
                    self.postState = PostState.error(PHError.noResult)
                }

            case .failure(let error):
                print("Error loading data \(error)")
                self.post = nil
                self.postState = PostState.error(error)
            }

            self.currentQuery = nil
        }
    }
}
