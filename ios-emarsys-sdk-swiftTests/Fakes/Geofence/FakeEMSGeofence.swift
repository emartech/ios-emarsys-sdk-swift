//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

@objc public class FakeEMSGeofence: NSObject, EMSGeofenceProtocol {

    public var eventHandler: EMSEventHandlerBlock!
    var callHandler: CallHandler!
    var error: NSError?
    var geofences: [EMSGeofence] = []
    var enabledValue: Bool = true
    var enterTriggerValue: Bool = true
    public var initialEnterTriggerEnabled: Bool {
        get {
            self.callHandler()
            return enterTriggerValue
        }
        set {
            self.callHandler()
        }
    }

    public override init() {
        let geofence = EMSGeofence(id: "testGeofence", lat: 47.4, lon: 27.5, r: 300, waitInterval: 50.3, triggers: [])
        geofences.append(geofence!)
    }

    public func requestAlwaysAuthorization() {
        self.callHandler()
    }

    public func registeredGeofences() -> [EMSGeofence] {
        self.callHandler()
        return geofences
    }

    public func enable() {
        self.callHandler()
    }

    public func enable(completionBlock: EMSCompletionBlock? = nil) {
        completionBlock?(self.error)
        self.callHandler(completionBlock)
    }

    public func disable() {
        self.callHandler()
    }

    public func isEnabled() -> Bool {
        self.callHandler()
        return enabledValue
    }


}
