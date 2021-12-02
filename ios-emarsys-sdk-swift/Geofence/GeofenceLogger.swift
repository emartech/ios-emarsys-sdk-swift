//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine
import EmarsysSDKExposed

class GeofenceLogger: GeofenceApi {
    let emsLoggingGeofence: EMSGeofenceProtocol

    override var initialEnterTriggerEnabled: Bool {
        get {
            emsLoggingGeofence.initialEnterTriggerEnabled
        }
        set {
            emsLoggingGeofence.initialEnterTriggerEnabled = newValue
        }
    }

    override var isEnabled: Bool {
        get {
            emsLoggingGeofence.isEnabled()
        }
    }

    init(emsLoggingGeofence: EMSGeofenceProtocol,
         eventStream: PassthroughSubject<Event, Error>) {
        self.emsLoggingGeofence = emsLoggingGeofence
        super.init(eventStream: eventStream)
    }

    override func requestAlwaysAuthorization() async {
        emsLoggingGeofence.requestAlwaysAuthorization()
    }

    override func registeredGeofences() async -> [Geofence] {
        emsLoggingGeofence.registeredGeofences()
        return []
    }

    override func enable() async throws {
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

    override func disable() async {
        emsLoggingGeofence.disable()
    }
}
