//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class GeofenceLogger: GeofenceApi {
    let emsLoggingGeofence: EMSGeofenceProtocol

    var eventPublisher: EventPublisher {
        get {
            emsLoggingGeofence.eventHandler
            return EventPublisher()
        }
    }

    var initialEnterTriggerEnabled: Bool {
        get {
            emsLoggingGeofence.initialEnterTriggerEnabled
        }
        set {
            emsLoggingGeofence.initialEnterTriggerEnabled = newValue
        }
    }

    var isEnabled: Bool {
        get {
            emsLoggingGeofence.isEnabled()
        }
    }

    init(emsLoggingGeofence: EMSGeofenceProtocol) {
        self.emsLoggingGeofence = emsLoggingGeofence
    }

    func requestAlwaysAuthorization() async {
        emsLoggingGeofence.requestAlwaysAuthorization()
    }

    func registeredGeofences() async -> [Geofence] {
        emsLoggingGeofence.registeredGeofences()
        return []
    }

    func enable() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingGeofence.enable { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    func disable() async {
        emsLoggingGeofence.disable()
    }
}
