//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

class Trigger: NSObject {
    let id: String
    let type: TriggerType
    let loiteringDelay: Int
    let action: [String: Any]

    init(id: String, type: TriggerType, loiteringDelay: Int, action: [String: Any]) {
        self.id = id
        self.type = type
        self.loiteringDelay = loiteringDelay
        self.action = action
    }

    override var hash: Int {
        var result = id.hashValue
        result = result &* 31 &+ type.hashValue
        result = result &* 31 &+ loiteringDelay.hashValue
        return result
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Trigger else {
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
        if self.type != object.type {
            return false
        }
        if self.loiteringDelay != object.loiteringDelay {
            return false
        }
        return true
    }
}