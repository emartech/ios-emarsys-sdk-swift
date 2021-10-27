//
//  Created by Emarsys on 2021. 10. 21..
//

import Foundation

@objc public class Emarsys: NSObject {
    
    @objc public static var push: Push {
        get {
            
        }
    }
    
    @objc public static var messageInbox: MessageInbox {
        get {

        }
    }
    
    @objc public static var inApp: InApp {
        get {
            
        }
    }
    
    @objc public static var geofence: Geofence {
        get {
            
        }
    }
    
    @objc public static var predict: Predict {
        get {
            
        }
    }
    
    @objc public static var config: Config {
        get {
            
        }
    }
    
    @objc public static var onEventAction: OnEventAction {
        get {
            
        }
    }
    
    @objc public func setup(_ config: EmarsysConfig) async {
        
    }
    
    @objc public func setAuthenticatedContact(_ contactFieldId: Int, _ openIdToken: String) async -> Error? {
        
    }
    
    @objc public func setContact(_ contactFieldId: Int, _ contactFieldValue: String) async -> Error? {
        
    }
    
    @objc public func clearContact() async -> Error? {
        
    }
    
    @objc public func trackCustomEvent(_ eventName: String, eventAttributes: [String: String]? = nil) async -> Error? {
        
    }
    
    @objc public func trackDeepLink(_ userActivity: NSUserActivity) async -> Error? {
        
    }
}
