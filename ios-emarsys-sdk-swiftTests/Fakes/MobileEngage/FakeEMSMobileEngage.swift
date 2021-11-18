//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
@testable import EmarsysSDKExposed
import ios_emarsys_sdk_swift

@objc public class FakeEMSMobileEngage: NSObject, EMSMobileEngageProtocol {
    var callHandler: CallHandler!
    var error: NSError? = nil
    
    public func setAuthenticatedContactWithContactFieldId(_ contactFieldId: NSNumber?, openIdToken: String?, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(contactFieldId, openIdToken, completionBlock)
    }
        
    public func setContactWithContactFieldId(_ contactFieldId: NSNumber?, contactFieldValue: String?) {
        self.callHandler(contactFieldId, contactFieldValue)
    }
    
    public func setContactWithContactFieldId(_ contactFieldId: NSNumber?, contactFieldValue: String?, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(contactFieldId, contactFieldValue, completionBlock)
    }
    
    public func clearContact() {
        self.callHandler()
    }
    
    public func clearContact(completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(completionBlock)
    }
    
    public func trackCustomEvent(withName eventName: String, eventAttributes: [String : String]? = nil) {
        self.callHandler(eventName, eventAttributes)
    }
    
    public func trackCustomEvent(withName eventName: String, eventAttributes: [String : String]? = nil, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(eventName, eventAttributes, completionBlock)
    }
}
