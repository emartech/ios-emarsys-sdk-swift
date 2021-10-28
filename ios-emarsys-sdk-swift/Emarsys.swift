//
//  Created by Emarsys on 2021. 10. 21..
//

import Foundation

@objc public class Emarsys: NSObject {
    
//    public static var push: Push {
//        get {
//
//        }
//    }
//
//    public static var messageInbox: MessageInbox {
//        get {
//
//        }
//    }
//
//    public static var inApp: InApp {
//        get {
//
//        }
//    }
//
//    public static var geofence: Geofence {
//        get {
//
//        }
//    }
//
//    public static var predict: Predict {
//        get {
//
//        }
//    }
//
//    public static var config: Config {
//        get {
//
//        }
//    }
//
//    public static var onEventAction: OnEventAction {
//        get {
//
//        }
//    }
//
    public func setup(_ config: EmarsysConfig) async throws {
        
    }
    
    public func setAuthenticatedContact(_ contactFieldId: Int, _ openIdToken: String) async throws {
        
    }
    
    public func setContact(_ contactFieldId: Int, _ contactFieldValue: String) async throws {
        
    }
    
    public func clearContact() async throws {
        
    }
    
    public func trackCustomEvent(_ eventName: String, eventAttributes: [String: String]? = nil) async throws {
        
    }
    
    public func trackDeepLink(_ userActivity: NSUserActivity) async throws {
        
    }
}
