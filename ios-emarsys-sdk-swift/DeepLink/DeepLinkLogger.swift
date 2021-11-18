//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class DeepLinkLogger: DeepLinkApi {
    
    let emsDeepLinkLogger: EMSDeepLinkProtocol
    
    init(emsDeepLinkLogger: EMSDeepLinkProtocol) {
        self.emsDeepLinkLogger = emsDeepLinkLogger
    }
    
    func trackDeepLink(userActivity: NSUserActivity) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsDeepLinkLogger.trackDeepLink(with: userActivity, sourceHandler: nil) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }

    }
}
