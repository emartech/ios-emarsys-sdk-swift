//
//  Created by Emarsys on 2021. 10. 26..
//

import Foundation
import UserNotifications

@objc public protocol Push: UNUserNotificationCenterDelegate {

    weak var delegate: UNUserNotificationCenterDelegate? { get set }

    var silentNotificationEventHandler: EventHandler { get set }

    var silentNotificationInformationBlock: NotificationInformationHandler { get set }

    var notificationEventHandler: EventHandler { get set }

    var notificationInformationBlock: NotificationInformationHandler { get set }

    func setPushToken(_ pushToken: Data) async throws

    func clearPushToken() async throws

    func trackMessageOpen(_ userInfo: [String: Any]) async throws

    func handleMessage(_ userInfo: [String: Any]) async throws

}
