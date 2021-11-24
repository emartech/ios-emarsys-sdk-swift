//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine

public class NotificationInformationPublisher: NSObject, Publisher {

    public typealias Output = NotificationInformation

    public typealias Failure = Error

    public func receive<S>(subscriber: S) where S: Subscriber, Error == S.Failure, NotificationInformation == S.Input {

    }
}