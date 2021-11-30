//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine
import EmarsysSDKExposed

class GeofenceInternal: GeofenceApi {

    let emsGeofence: EMSGeofenceProtocol
    let geofenceMapper: GeofenceMapper

    @objc override var initialEnterTriggerEnabled: Bool {
        get {
            emsGeofence.initialEnterTriggerEnabled
        }
        set {
            emsGeofence.initialEnterTriggerEnabled = newValue
        }
    }

    @objc override var isEnabled: Bool {
        get {
            emsGeofence.isEnabled()
        }
    }

    init(emsGeofence: EMSGeofenceProtocol,
         geofenceMapper: GeofenceMapper,
         eventStream: PassthroughSubject<Event, Error>) {
        self.emsGeofence = emsGeofence
        self.geofenceMapper = geofenceMapper
        super.init(eventStream: eventStream)
        self.emsGeofence.eventHandler = { [unowned self] name, payload in
            self.eventStream.send(Event(name, payload))
            self.eventHandler?(name, payload)
        }
    }

    @objc override func requestAlwaysAuthorization() async {
        emsGeofence.requestAlwaysAuthorization()
    }

    @objc override func registeredGeofences() async -> [Geofence] {
        geofenceMapper.map(emsGeofence.registeredGeofences())
    }

    @objc override func enable() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsGeofence.enable { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    override func disable() async {
        emsGeofence.disable()
    }
}
