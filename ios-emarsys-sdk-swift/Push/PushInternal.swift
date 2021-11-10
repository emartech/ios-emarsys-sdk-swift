//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class PushInternal: NSObject, PushApi {
    let emsPush: EMSPushNotificationProtocol
    var delegate: UNUserNotificationCenterDelegate?
    var silentNotificationEventPublisher: EventPublisher
    var silentNotificationInformationPublisher: NotificationInformationPublisher
    var notificationEventPublisher: EventPublisher
    var notificationInformationPublisher: NotificationInformationPublisher

    init(emsPush: EMSPushNotificationProtocol,
         delegate: UNUserNotificationCenterDelegate?,
         silentNotificationEventPublisher: EventPublisher,
         silentNotificationInformationPublisher: NotificationInformationPublisher,
         notificationEventPublisher: EventPublisher,
         notificationInformationPublisher: NotificationInformationPublisher) {
        self.emsPush = emsPush
        self.delegate = delegate
        self.silentNotificationEventPublisher = silentNotificationEventPublisher
        self.silentNotificationInformationPublisher = silentNotificationInformationPublisher
        self.notificationEventPublisher = notificationEventPublisher
        self.notificationInformationPublisher = notificationInformationPublisher
        super.init()
    }

    func setPushToken(_ pushToken: Data) async throws {
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

    func clearPushToken() async throws {
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

    func trackMessageOpen(_ userInfo: [String: Any]) async throws {
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

    func handleMessage(_ userInfo: [String: Any]) async {
        emsPush.handleMessage(userInfo: userInfo)
    }
}
