//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import ios_emarsys_sdk_swift

@objc public class FakeEMSInbox : NSObject, EMSMessageInboxProtocol {
    var error: NSError?
    var callHandler: CallHandler!
    var fakeResult: FakeResult = FakeResult()
    
    public func fetchMessages(resultBlock: @escaping EMSInboxMessageResultBlock) {
        resultBlock(fakeResult as EMSInboxResult, nil)
        self.callHandler(resultBlock)
    }
    
    public func addTag(tag: String, messageId: String) {
        self.callHandler(tag, messageId)
    }
    
    public func addTag(tag: String, messageId: String, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(tag, messageId, completionBlock)
    }

    public func removeTag(tag: String, messageId: String) {
        self.callHandler(tag, messageId)
    }
    
    public func removeTag(tag: String, messageId: String, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(tag, messageId, completionBlock)
    }
    
}
