//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

public class Event: NSObject {

    public let name: String

    public let payload: [String: Any]?

    init(_ name: String, _ payload: [String: Any]?) {
        self.name = name
        self.payload = payload
    }
}