//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import Combine

class InAppInternal: InAppApi {
    @objc override var eventHandler: EMSEventHandlerBlock? {
        get {
            self.eventHandler
        }
        set {
            self.eventHandler = newValue
        }
    }
    
    let emsInApp: EMSInAppProtocol
    
    init(emsInApp: EMSInAppProtocol, eventStream: PassthroughSubject<Event, Error>) {
        self.emsInApp = emsInApp
        super.init(eventStream: eventStream)
        self.emsInApp.eventHandler = { [unowned self] name, payload in
            self.eventStream.send(Event(name, payload))
            self.eventHandler?(name, payload)
        }
    }
    
    @objc override var isPaused: Bool {
        get {
            self.emsInApp.isPaused()
        }
    }
    
    @objc override func pause() async {
        emsInApp.pause()
    }
    
    @objc override func resume() async {
        emsInApp.resume()
    }
}
