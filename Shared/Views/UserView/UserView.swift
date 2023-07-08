//
//  UserView.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 13/10/2021.
//

import SwiftUI


struct UserHeader: View {
    let user: User

    var body: some View {
        VStack(alignment: .center) {
            ProfileImage(url: user.profileImage, size: 120)
            Text(user.name)
                .font(.title)
                .foregroundColor(.primary)
            Text("@\(user.username)")
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
}

//struct UserTabSelector: View {
//
//    @EnvironmentObject var configProvider: ConfigProvider
//
//    let selectedTab: UserTab
//    let action: (_ selectedTab: UserTab) -> Void
//
//    var body: some View {
//        HStack {
//            Button {
//                action(.votedPosts)
//            } label: {
//                Text("Voted Posts")
//            }
//            .tint(selectedTab == .votedPosts ? configProvider.config.theme.accentColor : .secondary)
//
//            Button {
//                action(.followingUsers)
//            } label: {
//                Text("Following Users")
//            }
//            .tint(selectedTab == .followingUsers ? configProvider.config.theme.accentColor : .secondary)
//        }
//        .padding()
//    }
//}



struct UserView: View {

    @EnvironmentObject var configProvider: ConfigProvider
    @StateObject var presenter = UserPresenter()
    @State private var selectedTab: Int = 0

    var id: String

    var body: some View {
        VStack {
            switch self.presenter.userState {
            case .error(let error):
                Text("Sorry, an error occurred! \(error.localizedDescription)")
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .user(let user, let selectedTab):
                VStack() {
                    UserHeader(user: user)
//                    UserTabSelector(selectedTab: selectedTab, action: { tab in
//                        presenter.setVisibleTab(tab: tab)
//                    })

                    Picker("Select user tab", selection: self.$selectedTab) {
                        Text("Voted Posts").tag(0)
                        Text("Following Users").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .tint(configProvider.config.theme.accentColor)
                    .padding()
                    .onChange(of: self.selectedTab) { newValue in
                        presenter.setVisibleTab(index: newValue)
                    }

                    VStack(alignment: .leading) {
                        switch selectedTab {
                        case .votedPosts(let votedPosts, let hasMore, let isLoadingMore):
                            List {
                                if votedPosts.count > 0 {
                                    Text("Upvotes (\(user.votedPosts.totalCount))")
                                        .foregroundColor(.secondary)
                                        .font(.headline)
                                }

                                Section {
                                    ForEach(votedPosts) { postNode in
                                        PostCell(post: postNode.fragments.postCellFragment)
                                    }
                                }

                                LoadMore(hasMore: hasMore, isLoadingMore: isLoadingMore) {
                                    presenter.loadUser(id: self.id)
                                }
                                .frame(maxWidth: .infinity)
                                .listSectionSeparator(.hidden)
                            }
                            .listStyle(PlainListStyle())
                        case .followingUsers(let followingUsers, let hasMore, let isLoadingMore):
                            List {
                                if followingUsers.count > 0 {
                                    Text("Following Users (\(user.votedPosts.totalCount))")
                                        .foregroundColor(.secondary)
                                        .font(.headline)
                                }

                                Section {
                                    ForEach(followingUsers) { userNode in
                                        HStack {
                                            AsyncImage(url: URL(string: userNode.profileImage ?? "")) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 44, height: 44)
                                            .cornerRadius(22)
                                            Text(userNode.name)
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                        }
                                    }
                                }

                                LoadMore(hasMore: hasMore, isLoadingMore: isLoadingMore) {
                                    presenter.loadUser(id: self.id)
                                }
                                .frame(maxWidth: .infinity)
                                .listSectionSeparator(.hidden)
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                }
            case .empty:
                Spacer()
            }
        }
        .onAppear() {
            self.presenter.loadUser(id: self.id)
        }
    }
}
