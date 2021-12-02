//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import Combine

class OnEventActionLogger: OnEventActionApi {
    var emsLoggingOnEventAction: EMSOnEventActionProtocol

    override var eventHandler: EMSEventHandlerBlock? {
        get {
            self.emsLoggingOnEventAction.eventHandler
        }
        set {
            self.emsLoggingOnEventAction.eventHandler = newValue
        }
    }

    init(emsLoggingOnEventAction: EMSOnEventActionProtocol, eventStream: PassthroughSubject<Event, Error>) {
        self.emsLoggingOnEventAction = emsLoggingOnEventAction
        super.init(eventStream: eventStream)
    }
}
