//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed


class OnEventActionInternal: OnEventActionApi {
    var emsOnEventAction: EMSOnEventActionProtocol

    var eventPublisher: EventPublisher {
        get {
            EventPublisher()
        }
    }

    init(emsOnEventAction: EMSOnEventActionProtocol) {
        self.emsOnEventAction = emsOnEventAction
    }
}
