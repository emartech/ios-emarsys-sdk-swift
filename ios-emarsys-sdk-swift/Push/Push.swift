//
//  Created by Emarsys on 2021. 10. 26..
//

import Foundation
import UserNotifications

@objc public protocol Push: UNUserNotificationCenterDelegate {
    
    @objc weak var delegate: UNUserNotificationCenterDelegate? {
        get
        set
    }
    
    @objc var silentMessageEventHandler: EventHandler {
        get
        set
    }
    
    @objc var silentMessageInformationBlock: NotificationInformationHandler {
        get
        set
        
    }
    
    @objc var notificationEventHandler: EventHandler {
        get
        set
        
    }
    
    @objc var notificationInformationBlock: NotificationInformationHandler {
        get
        set
        
    }
    
    @objc func setPushToken(_ pushToken: Data) async -> Error?
    
    @objc func clearPushToken() async -> Error?
    
    @objc func trackMessageOpen(_ userInfo: [String: Any]) async -> Error?
    
    @objc func handleMessage(_ userInfo: [String: Any])
    
}
