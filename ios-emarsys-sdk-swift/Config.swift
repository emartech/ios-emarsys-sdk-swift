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

    @objc public init(applicationCode: String? = nil,
                experimentalFeatures: [FlipperFeature]? = nil,
                enabledConsoleLogLevels: [LogLevelProtocol]? = nil,
                merchantId: String? = nil,
                sharedKeychainAccessGroup: String? = nil) {
        self.applicationCode = applicationCode
        self.experimentalFeatures = experimentalFeatures
        self.enabledConsoleLogLevels = enabledConsoleLogLevels
        self.merchantId = merchantId
        self.sharedKeychainAccessGroup = sharedKeychainAccessGroup
    }
}
