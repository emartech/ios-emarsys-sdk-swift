//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import UserNotifications

@objc public protocol PushApi: UNUserNotificationCenterDelegate {

    weak var delegate: UNUserNotificationCenterDelegate? { get set }

    var silentNotificationEventPublisher: EventPublisher { get }

    var silentNotificationInformationPublisher: NotificationInformationPublisher { get }

    var notificationEventPublisher: EventPublisher { get }

    var notificationInformationPublisher: NotificationInformationPublisher { get }

    func setPushToken(_ pushToken: Data) async throws

    func clearPushToken() async throws

    func trackMessageOpen(_ userInfo: [String: Any]) async throws

    func handleMessage(_ userInfo: [String: Any]) async throws

}
