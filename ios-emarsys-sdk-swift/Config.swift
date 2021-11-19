//
// Copyright (c)  Emarsys on 2021. 10. 27..
//

import Foundation

@objc public class Config: NSObject {

    @objc public let applicationCode: String?

    @objc public let experimentalFeatures: [FlipperFeature]?

    @objc public let enabledConsoleLogLevels: [LogLevelProtocol]?

    @objc public let merchantId: String?

    @objc public let sharedKeychainAccessGroup: String?

    @objc public init(applicationCode: String?,
                experimentalFeatures: [FlipperFeature]?,
                enabledConsoleLogLevels: [LogLevelProtocol]?,
                merchantId: String?,
                sharedKeychainAccessGroup: String?) {
        self.applicationCode = applicationCode
        self.experimentalFeatures = experimentalFeatures
        self.enabledConsoleLogLevels = enabledConsoleLogLevels
        self.merchantId = merchantId
        self.sharedKeychainAccessGroup = sharedKeychainAccessGroup
    }
}
