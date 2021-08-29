//
//  XCDYouTubeClient.swift
//  ProductHuntSwiftUI
//
//  Created by Alexis Bronchart on 20/09/2021.
//

import Foundation
import SwiftUI
import XCDYouTubeKit

extension XCDYouTubeClient {
    func getVideo(with identifier: String) async -> Result<XCDYouTubeVideo, Error> {
        await withCheckedContinuation { continuation in
            self.getVideoWithIdentifier(identifier) { video, error in
                if let video = video {
                    continuation.resume(returning: Result.success(video))
                } else if let error = error {
                    continuation.resume(returning: Result.failure(error))
                } else {
                    continuation.resume(returning: Result.failure(NSError(domain: XCDYouTubeVideoErrorDomain, code: XCDYouTubeErrorCode.unknown.rawValue, userInfo: nil)))
                }
            }
        }
    }
}
