//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

public class Geofence: NSObject {
    let id: String
    let lat: Double
    let lon: Double
    let radius: Double
    let waitInterval: Double?
    let triggers: [Trigger]

    init(id: String, lat: Double, lon: Double, radius: Double, waitInterval: Double?, triggers: [Trigger]) {
        self.id = id
        self.lat = lat
        self.lon = lon
        self.radius = radius
        self.waitInterval = waitInterval
        self.triggers = triggers
    }

    public override var hash: Int {
        var result = id.hashValue
        result = result &* 31 &+ lat.hashValue
        result = result &* 31 &+ lon.hashValue
        result = result &* 31 &+ radius.hashValue
        result = result &* 31 &+ (waitInterval?.hashValue ?? 0)
        result = result &* 31 &+ triggers.hashValue
        return result
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Geofence else {
            return false
        }
        if self === object {
            return true
        }
        if type(of: self) != type(of: object) {
            return false
        }
        if self.id != object.id {
            return false
        }
        if self.lat != object.lat {
            return false
        }
        if self.lon != object.lon {
            return false
        }
        if self.radius != object.radius {
            return false
        }
        if self.waitInterval != object.waitInterval {
            return false
        }
        if self.triggers != object.triggers {
            return false
        }
        return true
    }
}