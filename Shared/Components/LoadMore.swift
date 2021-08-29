//
//  LoadMore.swift
//  LoadMore
//
//  Created by Alexis Bronchart on 13/09/2021.
//

import SwiftUI

struct LoadMore: View {

    let hasMore: Bool
    let isLoadingMore: Bool
    let loadMore: () -> Void

    var body: some View {
        VStack {
            if isLoadingMore {
                ProgressView()
                Text("Loading more...")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear() {
            if hasMore && !isLoadingMore {
                loadMore()
            }
        }
    }
}


struct LoadMore_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadMore(hasMore: false, isLoadingMore: false) {
                fatalError("This shouldn't have been called")
            }
            LoadMore(hasMore: false, isLoadingMore: true) {

            }
            LoadMore(hasMore: true, isLoadingMore: true) {
                fatalError("This shouldn't have been called")
            }
        }
    }
}
