//
//  UserPresenter.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 13/10/2021.
//

import Foundation
import Apollo

// MARK: Types

typealias User = UserQuery.Data.User
typealias VotedPostConnection = UserQuery.Data.User.VotedPost
typealias VotedPost = UserQuery.Data.User.VotedPost.Edge.Node

typealias FollowingUsersConnection = UserFollowedQuery.Data.User.Following
typealias FollowingUser = UserFollowedQuery.Data.User.Following.Edge.Node

extension VotedPost: Identifiable {}
extension FollowingUser: Identifiable {}

enum UserTab {
    case votedPosts(votedPosts: [VotedPost], hasMore: Bool, isLoadingMore: Bool)
    case followingUsers(followingUsers: [FollowingUser], hasMore: Bool, isLoadingMore: Bool)
}

enum UserState {
    case empty
    case loading
    case user(user: User, selectedTab: UserTab)
    // I eventually removed the specific cases, and put the associated values for the tabs in the second enum UserTab (easier to write the view)
//    case userWithVotedPosts(user: User, votedPosts: [VotedPost], hasMore: Bool, isLoadingMore: Bool)
//    case userWithFollowedUsers(user: User, followingUsers: [FollowingUser], hasMore: Bool, isLoadingMore: Bool)
    case error(_: Error)
}

// MARK: Presenter

class UserPresenter: ObservableObject {

    // MARK: Publishers

    @Published var userState: UserState = .empty

    // MARK: Properties

    private var user: User?

    private var lastVotedPostConnection: VotedPostConnection?
    private var votedPosts: [VotedPost] = []

    private var lastFollowingUsersConnection: FollowingUsersConnection?
    private var followingUsers: [FollowingUser] = []

    private var currentQuery: Cancellable?

    // MARK: Internal

    private func loadUser(id: String, votedProductsFrom cursor: String?) {

        if let user = self.user {
            if let connection = self.lastVotedPostConnection, !connection.pageInfo.hasNextPage {
                self.userState = UserState.user(user: user, selectedTab: .votedPosts(votedPosts: self.votedPosts, hasMore: false, isLoadingMore: false))
                return
            }
            self.userState = UserState.user(user: user, selectedTab: .votedPosts(votedPosts: self.votedPosts, hasMore: true, isLoadingMore: true))
        } else {
            self.userState = UserState.loading
        }

        self.currentQuery = Network.instance.client.fetch(query: UserQuery(id: id, count: 10, cursor: cursor)) { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let graphQLResult):
                if let user = graphQLResult.data?.user,
                   let postsConnection = graphQLResult.data?.user?.votedPosts {
                    let posts = postsConnection.edges.compactMap({ $0.node })
                    let hasMore = postsConnection.pageInfo.hasNextPage

                    // update connection
                    self.lastVotedPostConnection = postsConnection

                    self.user = user

                    // if first load, init state
                    if cursor == nil {
                        self.votedPosts = posts
                        self.userState = UserState.user(user: user, selectedTab: .votedPosts(votedPosts: self.votedPosts, hasMore: true, isLoadingMore: true))
                    } else {
                        var existingPosts = self.votedPosts
                        existingPosts.append(contentsOf: posts)
                        self.votedPosts = existingPosts
                        self.userState = UserState.user(user: user, selectedTab: .votedPosts(votedPosts: existingPosts, hasMore: hasMore, isLoadingMore: false))
                    }
                } else {
                    self.userState = UserState.error(PHError.noResult)
                }

            case .failure(let error):
                print("Error loading data \(error)")
                self.user = nil
                self.userState = UserState.error(error)
            }

            self.currentQuery = nil
        }
    }

    private func loadUser(id: String, followingUsersFrom cursor: String?) {

        guard let loadedUser = self.user else {
            return
        }

        if let connection = self.lastFollowingUsersConnection, !connection.pageInfo.hasNextPage {
            self.userState = UserState.user(user: loadedUser, selectedTab: .followingUsers(followingUsers: self.followingUsers, hasMore: false, isLoadingMore: false))
            return
        }

        self.currentQuery = Network.instance.client.fetch(query: UserFollowedQuery(id: id, count: 10, cursor: cursor)) { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let graphQLResult):
                if let postsConnection = graphQLResult.data?.user?.following {
                    let followingUsers = postsConnection.edges.compactMap({ $0.node })
                    let hasMore = postsConnection.pageInfo.hasNextPage

                    // update connection
                    self.lastFollowingUsersConnection = postsConnection

                    // if first load, init state
                    if cursor == nil {
                        self.followingUsers = followingUsers
                        self.userState = UserState.user(user: loadedUser, selectedTab: .followingUsers(followingUsers: followingUsers, hasMore: hasMore, isLoadingMore: false))
                    } else {
                        var existingFollowingUsers = self.followingUsers
                        existingFollowingUsers.append(contentsOf: followingUsers)
                        self.followingUsers = existingFollowingUsers
                        self.userState = UserState.user(user: loadedUser, selectedTab: .followingUsers(followingUsers: existingFollowingUsers, hasMore: hasMore, isLoadingMore: false))
                    }
                } else {
                    self.userState = UserState.error(PHError.noResult)
                }

            case .failure(let error):
                print("Error loading data \(error)")
                self.user = nil
                self.userState = UserState.error(error)
            }

            self.currentQuery = nil
        }
    }

    // MARK: Functions

    func setVisibleTab(index: Int) {
        guard let loadedUser = self.user else {
            return
        }

        switch index {
        case 0:
            self.loadUser(id: loadedUser.id)
        case 1:
            self.loadFollowingUsers(for: loadedUser.id)
        default:
            return
        }
    }

    func loadUser(id: String) {
        if self.currentQuery != nil {
            return
        }

        guard let connection = self.lastVotedPostConnection else {
            self.loadUser(id: id, votedProductsFrom: nil)
            return
        }

        self.loadUser(id: id, votedProductsFrom: connection.pageInfo.endCursor)
    }

    func loadFollowingUsers(for userId: String) {
        if self.currentQuery != nil {
            return
        }

        guard let connection = self.lastFollowingUsersConnection else {
            self.loadUser(id: userId, followingUsersFrom: nil)
            return
        }

        self.loadUser(id: userId, followingUsersFrom: connection.pageInfo.endCursor)
    }
}
