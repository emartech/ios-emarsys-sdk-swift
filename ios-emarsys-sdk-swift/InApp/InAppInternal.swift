//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class InAppInternal: InAppApi {
    let emsInApp: EMSInAppProtocol

    var eventPublisher: EventPublisher {
        get {
            EventPublisher()
        }
    }

    init(emsInApp: EMSInAppProtocol) {
        self.emsInApp = emsInApp
    }

    var isPaused: Bool {
        get {
            emsInApp.isPaused()
        }
    }

    func pause() async {
        emsInApp.pause()
    }

    func resume() async {
        emsInApp.resume()
    }
}
