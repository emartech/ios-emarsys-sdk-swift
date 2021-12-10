//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

@objc class FakeDeviceInfoClient: NSObject ,EMSDeviceInfoClientProtocol, Fakable {
    var error: NSError? = nil
    
    func trackDeviceInfo(completionBlock: EMSCompletionBlock!) {
        self.callHandler?()
        completionBlock(error)
    }
    
    func sendDeviceInfo(completionBlock: EMSCompletionBlock!) {
        self.callHandler?()
        completionBlock(error)
    }
}
