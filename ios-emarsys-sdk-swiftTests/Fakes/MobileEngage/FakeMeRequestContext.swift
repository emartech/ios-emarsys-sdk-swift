//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class FakeMeRequestContext: MERequestContext, Fakable {
    override var timestampProvider: EMSTimestampProvider? {
        get {
            super.timestampProvider
        }
        set {
            super.timestampProvider = newValue
        }
    }

    override var uuidProvider: EMSUUIDProvider? {
        get {
            super.uuidProvider
        }
        set {
            super.uuidProvider = newValue
        }
    }

    override var deviceInfo: EMSDeviceInfo? {
        get {
            super.deviceInfo
        }
        set {
            super.deviceInfo = newValue
        }
    }

    override var storage: EMSStorage? {
        get {
            super.storage
        }
        set {
            super.storage = newValue
        }
    }

    override var contactFieldId: NSNumber? {
        get {
            super.contactFieldId
        }
        set {
            super.contactFieldId = newValue
        }
    }

    override var contactFieldValue: String? {
        get {
            super.contactFieldValue
        }
        set {
            super.contactFieldValue = newValue
        }
    }

    override var clientState: String? {
        get {
            super.clientState
        }
        set {
            super.clientState = newValue
        }
    }

    override var contactToken: String? {
        get {
            super.contactToken
        }
        set {
            super.contactToken = newValue
        }
    }

    override var refreshToken: String? {
        get {
            super.refreshToken
        }
        set {
            super.refreshToken = newValue
        }
    }

    override var applicationCode: String? {
        get {
            super.applicationCode
        }
        set {
            super.applicationCode = newValue
        }
    }

    override var openIdToken: String? {
        get {
            super.openIdToken
        }
        set {
            super.openIdToken = newValue
        }
    }
    
    init(timestampProvider: EMSTimestampProvider? = nil,
         uuidProvider: EMSUUIDProvider? = nil,
         deviceInfo: EMSDeviceInfo? = nil,
         storage: EMSStorage? = nil,
         contactFieldId: NSNumber? = nil,
         contactFieldValue: String? = nil,
         clientState: String? = nil,
         contactToken: String? = nil,
         refreshToken: String? = nil,
         applicationCode: String? = nil,
         openIdToken: String? = nil
    ) {
        super.init()
        self.timestampProvider = timestampProvider
        self.uuidProvider = uuidProvider
        self.deviceInfo = deviceInfo
        self.contactFieldId = contactFieldId
        self.contactFieldValue = contactFieldValue
        self.clientState = clientState
        self.contactToken = contactToken
        self.refreshToken = refreshToken
        self.applicationCode = applicationCode
        self.openIdToken = openIdToken
    }
}
