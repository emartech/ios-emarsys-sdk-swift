//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import Combine
import EmarsysSDKExposed

public class OnEventActionApi: NSObject {

    @objc public var eventHandler: EMSEventHandlerBlock?

    public let eventStream: PassthroughSubject<Event, Error>

    public init(eventStream: PassthroughSubject<Event, Error>) {
        self.eventStream = eventStream
    }
}
