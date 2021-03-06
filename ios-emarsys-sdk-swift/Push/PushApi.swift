//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import UserNotifications
import Combine
import EmarsysSDKExposed

public class PushApi: NSObject, UNUserNotificationCenterDelegate {

    @objc public weak var delegate: UNUserNotificationCenterDelegate?

    @objc public var silentNotificationEventHandler: EMSEventHandlerBlock?

    @objc public var silentNotificationInformationHandler: EMSSilentNotificationInformationBlock?

    @objc public var notificationEventHandler: EMSEventHandlerBlock?

    @objc public var notificationInformationHandler: EMSSilentNotificationInformationBlock?

    public let silentNotificationEventStream: PassthroughSubject<Event, Error>
    public let silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>
    public let notificationEventStream: PassthroughSubject<Event, Error>
    public let notificationInformationStream: PassthroughSubject<NotificationInformation, Error>

    @objc public func setPushToken(_ pushToken: Data) async throws {
        fatalError("Subclasses needs to implement the `setPushToken` method.")
    }

    @objc public func clearPushToken() async throws {
        fatalError("Subclasses needs to implement the `clearPushToken` method.")
    }

    @objc public func trackMessageOpen(_ userInfo: [String: Any]) async throws {
        fatalError("Subclasses needs to implement the `trackMessageOpen` method.")
    }

    @objc public func handleMessage(_ userInfo: [String: Any]) async {
        fatalError("Subclasses needs to implement the `handleMessage` method.")
    }

    public init(
            silentNotificationEventStream: PassthroughSubject<Event, Error>,
            silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>,
            notificationEventStream: PassthroughSubject<Event, Error>,
            notificationInformationStream: PassthroughSubject<NotificationInformation, Error>

    ) {
        self.silentNotificationEventStream = silentNotificationEventStream
        self.silentNotificationInformationStream = silentNotificationInformationStream
        self.notificationEventStream = notificationEventStream
        self.notificationInformationStream = notificationInformationStream
    }
}
