//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import Combine
import EmarsysSDKExposed

public class GeofenceApi: NSObject {

    @objc public var eventHandler: EMSEventHandlerBlock?

    public let eventStream: PassthroughSubject<Event, Error>

    @objc public var initialEnterTriggerEnabled: Bool {
        get {
            self.initialEnterTriggerEnabled
        }
        set {
            self.initialEnterTriggerEnabled = newValue
        }
    }

    @objc public var isEnabled: Bool {
        get {
            self.isEnabled
        }
    }

    @objc public func requestAlwaysAuthorization() async {

    }

    @objc public func registeredGeofences() async -> [Geofence] {
        []
    }

    @objc public func enable() async throws {

    }

    @objc public func disable() async {

    }

    public init(eventStream: PassthroughSubject<Event, Error>) {
        self.eventStream = eventStream
        super.init()
    }
}
