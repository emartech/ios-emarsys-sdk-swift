//
//  Copyright (c)  Emarsys on 2021. 10. 21..
//

import Foundation

public class Emarsys: NSObject {
    
//    public static var push: PushApi {
//        get {
//
//        }
//    }
//
//    public static var messageInbox: InboxApi {
//        get {
//
//        }
//    }
//
//    public static var inApp: InAppApi {
//        get {
//
//        }
//    }
//
//    public static var geofence: GeofenceApi {
//        get {
//
//        }
//    }
//
//    public static var predict: PredictApi {
//        get {
//
//        }
//    }
//
//    public static var config: ConfigApi {
//        get {
//
//        }
//    }
//
//    public static var onEventAction: OnEventActionApi {
//        get {
//
//        }
//    }

    public func setup(_ config: Config) async throws {
        
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
