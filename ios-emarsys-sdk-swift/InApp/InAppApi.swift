//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import Combine
import EmarsysSDKExposed

public class InAppApi: NSObject {

    @objc public var eventHandler: EMSEventHandlerBlock?

    public let eventStream: PassthroughSubject<Event, Error>

    @objc public var isPaused: Bool {
        get {
            self.isPaused
        }
    }

    @objc public func pause() async {

    }

    @objc public func resume() async {

    }

    public init(eventStream: PassthroughSubject<Event, Error>) {
        self.eventStream = eventStream
    }
}
