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

@objc public class FakeEMSInbox : NSObject, EMSMessageInboxProtocol {
    var error: NSError?
    var callHandler: (() -> ())!
    
    public func fetchMessages(resultBlock: @escaping EMSInboxMessageResultBlock) {
        resultBlock(FakeResult() as EMSInboxResult, nil)
        self.callHandler(
        )
    }
    
    public func addTag(tag: String, messageId: String) {
        self.callHandler()
    }
    
    public func addTag(tag: String, messageId: String, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler()
    }

    public func removeTag(tag: String, messageId: String) {
        self.callHandler()
    }
    
    public func removeTag(tag: String, messageId: String, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler()
    }
    
}
