//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import ios_emarsys_sdk_swift

public class FakeResult: EMSInboxResult {
    public override init() {
        super.init()
        self.messages = [InboxMessage()]
    }
}
