//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class ConfigInternal: ConfigApi {
    let emsConfig: EMSConfigProtocol

    var applicationCode: String {
        get {
           emsConfig.applicationCode()
        }
    }

    var merchantId: String {
        get {
            emsConfig.merchantId()
        }
    }

    var contactFieldId: Int {
        get {
            Int(truncating: emsConfig.contactFieldId())
        }
    }

    var hardwareId: String {
        get {
            emsConfig.hardwareId()
        }
    }

    var languageCode: String {
        get {
            emsConfig.languageCode()
        }
    }

    var pushSettings: [String: Any] {
        get {
            emsConfig.pushSettings() as! [String: Any]
        }
    }

    var sdkVersion: String {
        get {
            emsConfig.sdkVersion()
        }
    }

    init(emsConfig: EMSConfigProtocol) {
        self.emsConfig = emsConfig
    }

    func changeApplicationCode(_ applicationCode: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsConfig.changeApplicationCode(applicationCode: applicationCode) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    func changeMerchantId(_ merchantId: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsConfig.changeMerchantId(merchantId: merchantId) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
