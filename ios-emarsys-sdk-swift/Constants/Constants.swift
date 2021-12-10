//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

enum Constants {
    static let dbPath: String = (NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first?.appending("MEDB.db"))!
    static let sdkVersion: String = EMARSYS_SDK_VERSION
    static let suiteNames = [
        coreSuiteName,
        predictSuiteName,
        mobileEngageSuiteName,
        emarsysSdkSuiteName
    ]
    
    static let mobileEngageSuiteName = "com.emarsys.mobileengage"
    static let predictSuiteName = "com.emarsys.predict"
    static let coreSuiteName = "com.emarsys.core"
    static let emarsysSdkSuiteName = "com.emarsys.sdk"
}