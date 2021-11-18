//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

@objc public class FakeEMSDeepLink: NSObject, EMSDeepLinkProtocol {
    var callHandler: CallHandler!
    var error: NSError? = nil
    
    public func trackDeepLink(with userActivity: NSUserActivity, sourceHandler: EMSSourceHandler? = nil) -> Bool{
        self.trackDeepLink(with: userActivity, sourceHandler: sourceHandler, withCompletionBlock: nil)
    }
    
    public func trackDeepLink(with userActivity: NSUserActivity, sourceHandler: EMSSourceHandler?, withCompletionBlock completionBlock: EMSCompletionBlock? = nil) -> Bool {
        completionBlock?(self.error)
        callHandler(userActivity, sourceHandler, completionBlock)
        return false
    }
}
