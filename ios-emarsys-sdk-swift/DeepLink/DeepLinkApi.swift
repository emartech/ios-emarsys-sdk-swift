//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation

@objc public protocol DeepLinkApi {
    
    func trackDeepLink(userActivity: NSUserActivity) async throws
}
