//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class PushLogger: NSObject, PushApi {
    let emsLoggingPush: EMSPushNotificationProtocol
    var delegate: UNUserNotificationCenterDelegate?
    var silentNotificationEventPublisher: EventPublisher
    var silentNotificationInformationPublisher: NotificationInformationPublisher
    var notificationEventPublisher: EventPublisher
    var notificationInformationPublisher: NotificationInformationPublisher

    init(emsLoggingPush: EMSPushNotificationProtocol,
         delegate: UNUserNotificationCenterDelegate?,
         silentNotificationEventPublisher: EventPublisher,
         silentNotificationInformationPublisher: NotificationInformationPublisher,
         notificationEventPublisher: EventPublisher,
         notificationInformationPublisher: NotificationInformationPublisher) {
        self.emsLoggingPush = emsLoggingPush
        self.delegate = delegate
        self.silentNotificationEventPublisher = silentNotificationEventPublisher
        self.silentNotificationInformationPublisher = silentNotificationInformationPublisher
        self.notificationEventPublisher = notificationEventPublisher
        self.notificationInformationPublisher = notificationInformationPublisher
        super.init()
    }

    func setPushToken(_ pushToken: Data) async throws {
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

    func clearPushToken() async throws {
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

    func trackMessageOpen(_ userInfo: [String: Any]) async throws {
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

    func handleMessage(_ userInfo: [String: Any]) async {
        emsLoggingPush.handleMessage(userInfo: userInfo)
    }
}
