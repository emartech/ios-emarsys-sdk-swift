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
            fatalError("Subclasses needs to override the `isPaused`.")
        }
    }

    @objc public func pause() async {
        fatalError("Subclasses needs to implement the `pause` method.")
    }

    @objc public func resume() async {
        fatalError("Subclasses needs to implement the `resume` method.")
    }

    public init(eventStream: PassthroughSubject<Event, Error>) {
        self.eventStream = eventStream
    }
}
