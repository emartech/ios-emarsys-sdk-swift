//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

enum Constants {
    static let dbPath: String = (NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first?.appending("MEDB.db"))!
    static let sdkVersion: String = EMARSYS_SDK_VERSION
    static let suiteNames = [
        "com.emarsys.core",
        "com.emarsys.predict",
        "com.emarsys.mobileengage",
        "com.emarsys.sdk"
    ]
}