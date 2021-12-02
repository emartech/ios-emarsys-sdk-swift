//
//  Copyright (c)  Emarsys on 2021. 10. 21..
//

import Foundation
import EmarsysSDKExposed

@objc public class SwiftEmarsys: NSObject {
    
    public static var push: PushApi {
        get async {
            return try! await DependencyInjection.push()
        }
    }

    public static var inbox: InboxApi {
        get async {
            return try! await DependencyInjection.inbox()
        }
    }

    public static var inApp: InAppApi {
        get async {
            return try! await DependencyInjection.inApp()
        }
    }

    public static var geofence: GeofenceApi {
        get async {
            return try! await DependencyInjection.geofence()
        }
    }

    public static var predict: PredictApi {
        get async {
            return try! await DependencyInjection.predict()
        }
    }

    public static var onEventAction: OnEventActionApi {
        get async {
            return try! await DependencyInjection.onEventAction()
        }
    }

    public static var config: ConfigApi {
        get async {
            return try! await DependencyInjection.config()
        }
    }

    @objc public static func setup(_ config: Config) async throws {
        if let applicationCode = config.applicationCode, !applicationCode.isEmpty {
            MEExperimental.enable(EMSInnerFeature.mobileEngage)
            MEExperimental.enable(EMSInnerFeature.eventServiceV4)
        }
        if let merchantId = config.merchantId, !merchantId.isEmpty {
            MEExperimental.enable(EMSInnerFeature.predict)
        }
        await DependencyInjection.setup(EmarsysContainer(config))
    }
    
    @objc public static func setAuthenticatedContact(_ contactFieldId: Int, _ openIdToken: String) async throws {
        
    }
    
    @objc public static func setContact(_ contactFieldId: Int, _ contactFieldValue: String) async throws {
        
    }
    
    @objc public static func clearContact() async throws {
        
    }
    
    @objc public static func trackCustomEvent(_ eventName: String, eventAttributes: [String: String]? = nil) async throws {
        
    }
    
    @objc public static func trackDeepLink(_ userActivity: NSUserActivity) async throws {
        
    }
}
