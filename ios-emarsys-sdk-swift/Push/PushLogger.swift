//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import Combine

class PushLogger: PushApi {
    let emsLoggingPush: EMSPushNotificationProtocol

    init(emsLoggingPush: EMSPushNotificationProtocol,
         silentNotificationEventStream: PassthroughSubject<Event, Error>,
         silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>,
         notificationEventStream: PassthroughSubject<Event, Error>,
         notificationInformationStream: PassthroughSubject<NotificationInformation, Error>
    ) {
        self.emsLoggingPush = emsLoggingPush

        super.init(silentNotificationEventStream: silentNotificationEventStream,
                silentNotificationInformationStream: silentNotificationInformationStream,
                notificationEventStream: notificationEventStream,
                notificationInformationStream: notificationInformationStream)

        self.emsLoggingPush.silentMessageEventHandler = { [unowned self] name, payload in
            self.silentNotificationEventStream.send(Event(name, payload))
            self.silentNotificationEventHandler?(name, payload)
        }
        self.emsLoggingPush.silentMessageInformationBlock = { [unowned self]  notificationInformation in
            self.silentNotificationInformationStream.send(NotificationInformation(notificationInformation.campaignId))
            self.silentNotificationInformationHandler?(notificationInformation)
        }
        self.emsLoggingPush.notificationEventHandler = { [unowned self] name, payload in
            self.notificationEventStream.send(Event(name, payload))
            self.notificationEventHandler?(name, payload)
        }
        self.emsLoggingPush.notificationInformationBlock = { [unowned self]  notificationInformation in
            self.silentNotificationInformationStream.send(NotificationInformation(notificationInformation.campaignId))
            self.notificationInformationHandler?(notificationInformation)
        }
    }

    override func setPushToken(_ pushToken: Data) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingPush.setPushToken(pushToken: pushToken) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    override func clearPushToken() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingPush.clearPushToken { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    override func trackMessageOpen(_ userInfo: [String: Any]) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingPush.trackMessageOpen(userInfo: userInfo) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    override func handleMessage(_ userInfo: [String: Any]) async {
        emsLoggingPush.handleMessage(userInfo: userInfo)
    }
}
