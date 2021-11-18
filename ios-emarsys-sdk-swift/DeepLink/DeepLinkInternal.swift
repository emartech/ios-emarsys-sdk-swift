//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class DeepLinkInternal: DeepLinkApi {
    
    let emsDeepLink: EMSDeepLinkProtocol
    
    init(emsDeepLink: EMSDeepLinkProtocol) {
        self.emsDeepLink = emsDeepLink
    }
    
    func trackDeepLink(userActivity: NSUserActivity) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsDeepLink.trackDeepLink(with: userActivity, sourceHandler: nil) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
