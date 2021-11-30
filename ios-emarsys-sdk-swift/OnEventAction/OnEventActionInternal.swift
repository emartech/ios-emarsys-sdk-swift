//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import Combine

class OnEventActionInternal: OnEventActionApi {

    let emsOnEventAction: EMSOnEventActionProtocol

    init(emsOnEventAction: EMSOnEventActionProtocol, eventStream: PassthroughSubject<Event, Error>) {
        self.emsOnEventAction = emsOnEventAction
        super.init(eventStream: eventStream)
        self.emsOnEventAction.eventHandler = { [unowned self] name, payload in
            self.eventStream.send(Event(name, payload))
            self.eventHandler?(name, payload)
        }
    }
}
