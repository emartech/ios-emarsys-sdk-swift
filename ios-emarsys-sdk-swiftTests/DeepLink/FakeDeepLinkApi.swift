//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import ios_emarsys_sdk_swift

class FakeDeepLinkApi: DeepLinkApi, Fakable {
    
    func trackDeepLink(userActivity: NSUserActivity) async throws {
        self.callHandler?(userActivity)
    }
}
