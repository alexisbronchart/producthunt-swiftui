//
//  PostsFeedView.swift
//  PostsFeedView
//
//  Created by Alexis Bronchart on 01/09/2021.
//

import SwiftUI
import SwiftUINavigation

struct PostsFeedView: View {

    enum Route {
        case windowBound
    }

    @StateObject var presenter = PostsFeedPresenter()
    @State var route: Route?

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
                        ForEach(posts) { postNode in
                            PostCell(post: postNode.fragments.postCellFragment)
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
        .navigationTitle("Products")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.route = .windowBound
                } label: {
                    Image(systemName: "rectangle.inset.filled.and.person.filled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.accentColor)
                }
            }
        }
        .refreshable {
            self.presenter.reload()
        }
        .onAppear() {
            self.loadPosts()
        }
        .navigationDestination(unwrapping: $route, case: /Route.windowBound) { _ in
            WindowBoundsView()
        }
    }

    func loadPosts() {
        self.presenter.loadMore()
    }
}
