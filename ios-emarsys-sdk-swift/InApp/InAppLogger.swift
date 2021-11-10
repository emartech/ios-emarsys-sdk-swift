//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class InAppLogger: InAppApi {
    let emsLoggingInApp: EMSInAppProtocol

    var eventPublisher: EventPublisher {
        get {
            emsLoggingInApp.eventHandler
            return EventPublisher()
        }
    }

    init(emsLoggingInApp: EMSInAppProtocol) {
        self.emsLoggingInApp = emsLoggingInApp
    }

    var isPaused: Bool {
        get {
            emsLoggingInApp.isPaused()
        }
    }

    func pause() async {
        emsLoggingInApp.pause()
    }

    func resume() async {
        emsLoggingInApp.resume()
    }
}
