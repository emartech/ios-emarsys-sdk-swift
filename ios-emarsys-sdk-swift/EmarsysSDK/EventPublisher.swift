//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine

public class EventPublisher: NSObject, Publisher {

    public typealias Output = Event

    public typealias Failure = Error

    public func receive<S>(subscriber: S) where S: Subscriber, Error == S.Failure, Event == S.Input {

    }

}