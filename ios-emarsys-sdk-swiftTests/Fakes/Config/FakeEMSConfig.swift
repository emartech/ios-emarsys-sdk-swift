//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
@testable import EmarsysSDKExposed
import ios_emarsys_sdk_swift

@objc public class FakeEMSConfig: NSObject, EMSConfigProtocol {
    var callHandler: CallHandler!
    var error: NSError?
    var applicationCodeValue: String = "testApplicationCode"
    var merchantIdValue: String = "testMerchantId"
    var contactFieldIdValue: NSNumber = 2
    var hardwareIddValue: String = "testHardwareId"
    var languageCodeValue: String = "testLanguageCode"
    var pushSettingsValue: [AnyHashable: Any] = ["test": "push"]
    var sdkVersionValue: String = "testSdkVersionValue"

    public func changeApplicationCode(applicationCode: String?, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(applicationCode, completionBlock)
    }

    public func changeMerchantId(merchantId: String?) {
        self.callHandler(merchantId)
    }

    public func changeMerchantId(merchantId: String?, completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(merchantId, completionBlock)
    }

    public func applicationCode() -> String {
        self.callHandler()
        return self.applicationCodeValue
    }

    public func merchantId() -> String {
        self.callHandler()
        return self.merchantIdValue
    }

    public func contactFieldId() -> NSNumber {
        self.callHandler()
        return self.contactFieldIdValue
    }

    public func hardwareId() -> String {
        self.callHandler()
        return self.hardwareIddValue
    }

    public func languageCode() -> String {
        self.callHandler()
        return self.languageCodeValue
    }

    public func pushSettings() -> [AnyHashable: Any] {
        self.callHandler()
        return self.pushSettingsValue
    }

    public func sdkVersion() -> String {
        self.callHandler()
        return self.sdkVersionValue
    }


}
