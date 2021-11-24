//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine
import EmarsysSDKExposed

class InAppLogger: InAppApi {
    let emsLoggingInApp: EMSInAppProtocol

    @objc var emsEventHandler: EMSEventHandlerBlock? {
        get {
            self.emsLoggingInApp.eventHandler
        }
        set {
            self.emsLoggingInApp.eventHandler = newValue
        }
    }

    init(emsLoggingInApp: EMSInAppProtocol,
         eventStream: PassthroughSubject<Event, Error>) {
        self.emsLoggingInApp = emsLoggingInApp
        super.init(eventStream: eventStream)
    }
    
    @objc override var isPaused: Bool {
        get {
            self.emsLoggingInApp.isPaused()
        }
    }
    
    @objc override func pause() async {
        emsLoggingInApp.pause()
    }
    
    @objc override func resume() async {
        emsLoggingInApp.resume()
    }
}
