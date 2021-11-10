//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class GeofenceInternal: GeofenceApi {

    let emsGeofence: EMSGeofenceProtocol
    let geofenceMapper: GeofenceMapper

    var eventPublisher: EventPublisher {
        get {
            EventPublisher()
        }
    }

    var initialEnterTriggerEnabled: Bool {
        get {
            emsGeofence.initialEnterTriggerEnabled
        }
        set {
            emsGeofence.initialEnterTriggerEnabled = newValue
        }
    }

    var isEnabled: Bool {
        get {
            emsGeofence.isEnabled()
        }
    }

    init(emsGeofence: EMSGeofenceProtocol,
         geofenceMapper: GeofenceMapper) {
        self.emsGeofence = emsGeofence
        self.geofenceMapper = geofenceMapper
    }

    func requestAlwaysAuthorization() async {
        emsGeofence.requestAlwaysAuthorization()
    }

    func registeredGeofences() async -> [Geofence] {
        geofenceMapper.map(emsGeofence.registeredGeofences())
    }

    func enable() async throws {
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

    func disable() async {
        emsGeofence.disable()
    }
}
