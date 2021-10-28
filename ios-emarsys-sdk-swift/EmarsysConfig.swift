//
// Created by Emarsys on 2021. 10. 27..
//

import Foundation

public class EmarsysConfig: NSObject {
    let applicationCode: String
    let experimentalFeatures: FlipperFeature
    let enabledConsoleLogLevels: LogLevelProtocol
    let merchantId: String
    let sharedKeychainAccessGroup: String

    public init(applicationCode: String,
                experimentalFeatures: FlipperFeature,
                enabledConsoleLogLevels: LogLevelProtocol,
                merchantId: String,
                sharedKeychainAccessGroup: String) {
        self.applicationCode = applicationCode
        self.experimentalFeatures = experimentalFeatures
        self.enabledConsoleLogLevels = enabledConsoleLogLevels
        self.merchantId = merchantId
        self.sharedKeychainAccessGroup = sharedKeychainAccessGroup
    }
}
