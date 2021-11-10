//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class GeofenceMapper {

    func map(_ geofences: [EMSGeofence]) -> [Geofence] {
        geofences.map { emsGeofence -> Geofence in
            Geofence(id: emsGeofence.id,
                    lat: emsGeofence.lat,
                    lon: emsGeofence.lon,
                    radius: Double(emsGeofence.r),
                    waitInterval: emsGeofence.waitInterval,
                    triggers: mapTriggers(emsTriggers: emsGeofence.triggers)
            )
        }
    }

    private func mapTriggers(emsTriggers: [EMSGeofenceTrigger]) -> [Trigger] {
        emsTriggers.map { emsTrigger -> Trigger in
            Trigger(id: emsTrigger.id,
                    type: TriggerType(rawValue: emsTrigger.type)!,
                    loiteringDelay: Int(emsTrigger.loiteringDelay),
                    action: emsTrigger.action)
        }
    }
}