//
//  ProfileImage.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 14/10/2021.
//

import SwiftUI

struct ProfileImage: View {

    let url: String?
    let size: Double

    var body: some View {
        AsyncImage(url: URL(string: self.url ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
        .cornerRadius(size/2)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static let url = "https://media-exp1.licdn.com/dms/image/C4D03AQElt4eI6puCgw/profile-displayphoto-shrink_800_800/0/1516892662786?e=1639612800&v=beta&t=5QGApIms3T6U1dgDrlRDis-rGpT8wK_KfSGNe7OIywE"
    static var previews: some View {
        Group {
            ProfileImage(url: url, size: 24)
            ProfileImage(url: url, size: 48)
            ProfileImage(url: url, size: 100)
        }
    }
}
