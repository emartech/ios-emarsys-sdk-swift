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
            fatalError("Subclasses needs to override the `initialEnterTriggerEnabled`.")
        }
        set {
            fatalError("Subclasses needs to override the `initialEnterTriggerEnabled`.")
        }
    }

    @objc public var isEnabled: Bool {
        get {
            fatalError("Subclasses needs to override the `isEnabled`.")
        }
    }

    @objc public func requestAlwaysAuthorization() async {
        fatalError("Subclasses needs to implement the `requestAlwaysAuthorization` method.")
    }

    @objc public func registeredGeofences() async -> [Geofence] {
        fatalError("Subclasses needs to implement the `registeredGeofences` method.")
    }

    @objc public func enable() async throws {
        fatalError("Subclasses needs to implement the `enable` method.")
    }

    @objc public func disable() async {
        fatalError("Subclasses needs to implement the `disable` method.")
    }

    public init(eventStream: PassthroughSubject<Event, Error>) {
        self.eventStream = eventStream
        super.init()
    }
}
