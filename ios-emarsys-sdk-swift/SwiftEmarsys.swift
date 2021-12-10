//
//  Copyright (c)  Emarsys on 2021. 10. 21..
//

import Foundation
import EmarsysSDKExposed

@SdkActor
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
        DependencyInjection.setup(EmarsysContainer(config))
        
        var container = try await DependencyInjection.dependencyContainer()

        if (container.meRequestContext.contactToken == nil && !container.meRequestContext.hasContactIdentification()) {
            try await container.deviceInfoClient.trackDeviceInfo()
            try await container.mobileEngage.setContact(contactFieldId: nil, contactFieldValue: nil)
        }
    }
    
    @objc public static func setAuthenticatedContact(_ contactFieldId: NSNumber, _ openIdToken: String) async throws {
        try await DependencyInjection.mobileEngage().setAuthenticatedContact(contactFieldId: contactFieldId, openIdToken: openIdToken)
        MEExperimental.disableFeature(EMSInnerFeature.predict)
    }
    
    @objc public static func setContact(_ contactFieldId: NSNumber, _ contactFieldValue: String) async throws {
        if (MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage) ||
            !MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage) &&
            !MEExperimental.isFeatureEnabled(EMSInnerFeature.predict)) {
            try await DependencyInjection.mobileEngage().setContact(contactFieldId: contactFieldId, contactFieldValue: contactFieldValue)
        }
        if (MEExperimental.isFeatureEnabled(EMSInnerFeature.predict)) {
            try await (DependencyInjection.predict() as! ExposedPredict).setContact(contactFieldId: contactFieldId,
                                                                                    contactFieldValue: contactFieldValue)
        }
    }
    
    @objc public static func clearContact() async throws {
        if (MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage) ||
            !MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage) &&
            !MEExperimental.isFeatureEnabled(EMSInnerFeature.predict)) {
            try await DependencyInjection.mobileEngage().clearContact()
        }
        
        if MEExperimental.isFeatureEnabled(EMSInnerFeature.predict) {
            try await (DependencyInjection.predict() as! ExposedPredict).clearContact()
        }
    }
    
    @objc public static func trackCustomEvent(_ eventName: String, eventAttributes: [String: String]? = nil) async throws {
        try await DependencyInjection.mobileEngage().trackCustomEvent(eventName: eventName, eventAttributes: eventAttributes)
    }
    
    @objc public static func trackDeepLink(_ userActivity: NSUserActivity) async throws {
        try await DependencyInjection.deepLink().trackDeepLink(userActivity: userActivity)
    }
}
