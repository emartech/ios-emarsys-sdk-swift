//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class OnEventActionLogger: OnEventActionApi {
    var emsLoggingOnEventAction: EMSOnEventActionProtocol

    var eventPublisher: EventPublisher {
        get {
            emsLoggingOnEventAction.eventHandler
            return EventPublisher()
        }
    }

    init(emsLoggingOnEventAction: EMSOnEventActionProtocol) {
        self.emsLoggingOnEventAction = emsLoggingOnEventAction
    }
}