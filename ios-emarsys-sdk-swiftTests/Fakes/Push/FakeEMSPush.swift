//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
@testable import EmarsysSDKExposed
import ios_emarsys_sdk_swift

@objc public class FakeEMSPush: NSObject, EMSPushNotificationProtocol {

    public var delegate: UNUserNotificationCenterDelegate? = nil

    public var silentMessageEventHandler: EMSEventHandlerBlock!

    public var silentMessageInformationBlock: EMSSilentNotificationInformationBlock!

    public var notificationEventHandler: EMSEventHandlerBlock!

    public var notificationInformationBlock: EMSSilentNotificationInformationBlock!

    var callHandler: CallHandler!
    var error: NSError?
    var pushTokenValue: Data?

    public func setPushToken(_ pushToken: Data) {
        self.callHandler(pushToken)
    }

    public func setPushToken(pushToken: Data, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(pushToken, completionBlock)
    }

    public func pushToken() -> Data? {
        self.callHandler()
        return self.pushTokenValue
    }

    public func clearPushToken() {
        self.callHandler()
    }

    public func clearPushToken(completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(completionBlock)
    }


    public func trackMessageOpen(userInfo: [AnyHashable: Any] = [:]) {
        self.callHandler(userInfo)
    }

    public func trackMessageOpen(userInfo: [AnyHashable: Any] = [:], completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(userInfo, completionBlock)
    }

    public func handleMessage(userInfo: [AnyHashable: Any] = [:]) {
        self.callHandler(userInfo)
    }
}
