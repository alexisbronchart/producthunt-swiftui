//
//  PostView.swift
//  PostView
//
//  Created by Alexis Bronchart on 01/09/2021.
//

import SwiftUI

struct PostView: View {

    @StateObject var presenter = PostPresenter()
    var id: String
    var title: String

    var body: some View {
        VStack {
            switch self.presenter.postState {
            case .error(let error):
                Text("Sorry, an error occurred! \(error.localizedDescription)")
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .post(let post):
                ScrollView {
                    VStack {
                        MediaView(medias: post.media)
                        VStack{
                            Text(post.description ?? "")
                        }
                        .padding()
                    }
                }
            case .empty:
                Spacer()
            }
        }
        .navigationBarTitle(self.title)
        .onAppear() {
            self.presenter.loadPost(id: self.id)
        }
    }
}
