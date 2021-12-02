//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import Combine

class PushInternal: PushApi {

    let emsPush: EMSPushNotificationProtocol

    init(emsPush: EMSPushNotificationProtocol,
         silentNotificationEventStream: PassthroughSubject<Event, Error>,
         silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>,
         notificationEventStream: PassthroughSubject<Event, Error>,
         notificationInformationStream: PassthroughSubject<NotificationInformation, Error>
    ) {
        self.emsPush = emsPush
        super.init(silentNotificationEventStream: silentNotificationEventStream,
                silentNotificationInformationStream: silentNotificationInformationStream,
                notificationEventStream: notificationEventStream,
                notificationInformationStream: notificationInformationStream)
        self.emsPush.silentMessageEventHandler = { [unowned self] name, payload in
            self.silentNotificationEventStream.send(Event(name, payload))
            self.silentNotificationEventHandler?(name, payload)
        }
        self.emsPush.silentMessageInformationBlock = { [unowned self]  notificationInformation in
            self.silentNotificationInformationStream.send(NotificationInformation(notificationInformation.campaignId))
            self.silentNotificationInformationHandler?(notificationInformation)
        }
        self.emsPush.notificationEventHandler = { [unowned self] name, payload in
            self.notificationEventStream.send(Event(name, payload))
            self.notificationEventHandler?(name, payload)
        }
        self.emsPush.notificationInformationBlock = { [unowned self]  notificationInformation in
            self.notificationInformationStream.send(NotificationInformation(notificationInformation.campaignId))
            self.notificationInformationHandler?(notificationInformation)
        }
    }

    override var delegate: UNUserNotificationCenterDelegate? {
        didSet {
            self.emsPush.delegate = delegate
        }
    }

    override func setPushToken(_ pushToken: Data) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsPush.setPushToken(pushToken: pushToken) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    public override func clearPushToken() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsPush.clearPushToken { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    public override func trackMessageOpen(_ userInfo: [String: Any]) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsPush.trackMessageOpen(userInfo: userInfo) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    public override func handleMessage(_ userInfo: [String: Any]) async {
        emsPush.handleMessage(userInfo: userInfo)
    }
}
