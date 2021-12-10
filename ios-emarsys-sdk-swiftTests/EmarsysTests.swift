//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
import Combine
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class EmarsysTests: XCTestCase {
    
    var mobileEngageConfig: Config!
    var predictConfig: Config!
    var emptyConfig: Config!
    var allFeatureConfig: Config!
    var configWithEmptyStrings: Config!
    let contactFieldId = NSNumber(integerLiteral: 2575)
    let contactFieldValue = "testContactFieldValue"
    let openIdToken = "testOpenIdToken"
    
    var fakeMobileEngageApi = FakeMobileEngageApi()
    var fakeLoggingME = FakeMobileEngageApi()
    var fakeDeepLinkApi = FakeDeepLinkApi()
    var fakePredict = FakePredictApi()
    var fakeLoggingPredict = FakePredictApi()
    var fakeDeviceInfoClient = FakeDeviceInfoClient()
    
    var resultContactFieldId: NSNumber? = nil
    var resultContactFieldValue: String? = nil
    var resultOpenIdToken: String? = nil
    
    var meWasCalled = false
    var meLoggingWasCalled = false
    var predictWasCalled = false
    var predictLoggingWasCalled = false
    
    override func setUp() {
        super.setUp()
        self.mobileEngageConfig = Config(applicationCode: "EMS11-C3FD3")
        
        self.predictConfig = Config(merchantId: "testMerchantId")
        
        self.emptyConfig = Config()
        
        self.configWithEmptyStrings = Config(applicationCode: "", merchantId: "")
        
        self.allFeatureConfig = Config(applicationCode: "EMS11-C3FD3", merchantId: "testMerchantId")
        
        self.resultContactFieldId = nil
        self.resultContactFieldValue = nil
        self.resultOpenIdToken = nil
        self.meWasCalled = false
        self.meLoggingWasCalled = false
        self.predictWasCalled = false
        self.predictLoggingWasCalled = false
    }
    
    override func tearDown() {
        DependencyInjection.teardown()
        teardownEmarsys()
    }
    
    func testSetup_shouldEnableMobileEngageAndEventServiceV4_whenApplicationCodeIsAvailableInConfig() async throws {
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
        } catch {
        }
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldPredict_whenMerchantIdIsAvailableInConfig() async throws {
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
        } catch {
        }
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_mobileEngageAndEventServiceV4FeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
        } catch {
        }
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_PredictFeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
        } catch {
        }
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_shouldSetupDependencyContainer() async throws {
        var result: EmarsysDependency? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = try await DependencyInjection.dependencyContainer()
        } catch {
        }
        
        XCTAssertNotNil(result)
    }
    
    func testConfig_shouldReturnConfig() async throws {
        var result: ConfigApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.config
        }
        
        XCTAssertNotNil(result)
    }
    
    func testPush_shouldReturnPushInternal() async throws {
        var result: PushApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.push
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushInternal)
    }
    
    
    func testPush_shouldReturnPushLogger() async throws {
        var result: PushApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.push
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushLogger)
    }
    
    func testPush_shouldReturnInboxInternal() async throws {
        var result: InboxApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.inbox
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxInternal)
    }
    
    
    func testPush_shouldReturnInboxLogger() async throws {
        var result: InboxApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.inbox
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxLogger)
    }
    
    func testPush_shouldReturnInAppInternal() async throws {
        var result: InAppApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.inApp
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppInternal)
    }
    
    
    func testPush_shouldReturnInAppLogger() async throws {
        var result: InAppApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.inApp
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppLogger)
    }
    
    func testPush_shouldReturnGeofenceInternal() async throws {
        var result: GeofenceApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.geofence
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceInternal)
    }
    
    
    func testPush_shouldReturnGeofenceLogger() async throws {
        var result: GeofenceApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.geofence
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceLogger)
    }
    
    func testPush_shouldReturnPredictInternal() async throws {
        let container = await EmarsysContainer(self.predictConfig)
        await DependencyInjection.setup(FakeDependencyContainer(container: container,
                                                                deviceInfoClient: self.fakeDeviceInfoClient,
                                                                mobileEngage: self.fakeMobileEngageApi,
                                                                loggingMobileEngage: self.fakeLoggingME,
                                                                deepLink:fakeDeepLinkApi))
        
        var result: PredictApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.predict
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictInternal)
    }
    
    
    func testPush_shouldReturnPredictLogger() async throws {
        let container = await EmarsysContainer(self.mobileEngageConfig)
        await DependencyInjection.setup(FakeDependencyContainer(container: container,
                                                                deviceInfoClient: self.fakeDeviceInfoClient,
                                                                mobileEngage: self.fakeMobileEngageApi,
                                                                loggingMobileEngage: self.fakeLoggingME,
                                                                deepLink:fakeDeepLinkApi))
        var result: PredictApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.predict
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictLogger)
    }
    
    func testPush_shouldReturnOnEventActionInternal() async throws {
        var result: OnEventActionApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = await SwiftEmarsys.onEventAction
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionInternal)
    }
    
    
    func testPush_shouldReturnOnEventActionLogger() async throws {
        var result: OnEventActionApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.onEventAction
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionLogger)
    }
    
    func testSetup_shouldEnableMobileEngageAndEventService_whenConfigHasApplicationCode() async throws {
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldNotEnableMobileEngageAndEventService_whenConfigHasEmptyApplicationCode() async throws {
        try await SwiftEmarsys.setup(configWithEmptyStrings)
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldEnablePredict_whenConfigHasMerchantId() async throws {
        try await SwiftEmarsys.setup(predictConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_shouldNotEnablePredict_whenConfigHasEmptyMerchantId() async throws {
        try await SwiftEmarsys.setup(configWithEmptyStrings)
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_shouldTrackDeviceInfoAndSetAnonymContact_whenThereIsNoContactTokenAndNoAuthorizationInRequestContext() async throws {
        var trackDeviceInfoWasCalled = false
        var meSetContactWasCalled = false
        var contactFieldId: NSNumber? = nil
        var contactFieldValue: String? = nil
        
        self.fakeDeviceInfoClient.callHandler = { (_ params: Any?...) in
            trackDeviceInfoWasCalled = true
        }
        self.fakeMobileEngageApi.callHandler = { (_ params: Any?...) in
            contactFieldId = params[0] as? NSNumber
            contactFieldValue = params[1] as? String
            meSetContactWasCalled = true
        }
        
        let container = await EmarsysContainer(self.mobileEngageConfig)
                  await DependencyInjection.setup(FakeDependencyContainer(container: container,
                                                                          meRequestContext: FakeMeRequestContext(),
                                                                          deviceInfoClient: self.fakeDeviceInfoClient,
                                                                          mobileEngage: self.fakeMobileEngageApi,
                                                                          loggingMobileEngage: self.fakeLoggingME,
                                                                          deepLink:fakeDeepLinkApi,
                                                                          predict: self.fakePredict,
                                                                          loggingPredict: self.fakeLoggingPredict))
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        
        XCTAssertNil(contactFieldId)
        XCTAssertNil(contactFieldValue)
        XCTAssertTrue(meSetContactWasCalled)
        XCTAssertTrue(trackDeviceInfoWasCalled)
    }
    
    func testSetAuthenticatedContact_shouldDelegateCallToInternalInstanceAndDisablePredict() async throws {
        let allFeatureConfig = Config(applicationCode: "EMS11-C3FD3",
                                      merchantId: "testMerchantId")
        
        let container = await EmarsysContainer(allFeatureConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.resultContactFieldId = params[0] as? NSNumber
            self.resultOpenIdToken = params[1] as? String
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container, mobileEngage: self.fakeMobileEngageApi)
        DependencyInjection.setup(fakeContainer)
        try await SwiftEmarsys.setup(allFeatureConfig)
        
        try await SwiftEmarsys.setAuthenticatedContact(self.contactFieldId, self.openIdToken)
        
        XCTAssertEqual(self.resultContactFieldId, self.contactFieldId)
        XCTAssertEqual(self.resultOpenIdToken, self.openIdToken)
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetContact_shouldDelegateCallToLoggingInstanceButNotPredict() async throws {
        let container = await EmarsysContainer(self.emptyConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.resultContactFieldId = params[0] as? NSNumber
            self.resultContactFieldValue = params[1] as? String
        }
        
        fakeLoggingME.callHandler = { [unowned self] (_ params: Any?...) in
            self.meLoggingWasCalled = true
        }
        
        fakeLoggingPredict.callHandler = { [unowned self] (_ params: Any?...) in
            self.predictLoggingWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          mobileEngage: self.fakeMobileEngageApi,
                                                          loggingMobileEngage: self.fakeLoggingME,
                                                          loggingPredict: self.fakeLoggingPredict)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.emptyConfig)
        
        try await SwiftEmarsys.setContact(self.contactFieldId, self.contactFieldValue)
        
        XCTAssertNil(self.resultContactFieldId)
        XCTAssertNil(self.resultContactFieldValue)
        XCTAssertTrue(self.meLoggingWasCalled)
        XCTAssertFalse(self.predictLoggingWasCalled)
    }
    
    func testSetContact_shouldDelegateCallToPredictInstanceButNotMobileEngage() async throws {
        let container = await EmarsysContainer(self.predictConfig)
        await DependencyInjection.setup(FakeDependencyContainer(container: container,
                                                                deviceInfoClient: self.fakeDeviceInfoClient,
                                                                mobileEngage: self.fakeMobileEngageApi,
                                                                loggingMobileEngage: self.fakeLoggingME,
                                                                deepLink:fakeDeepLinkApi,
                                                                predict: self.fakePredict))
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.meWasCalled = true
        }
        
        fakeLoggingME.callHandler = { [unowned self] (_ params: Any?...) in
            self.meLoggingWasCalled = true
        }
        
        fakePredict.callHandler = { [unowned self] (_ params: Any?...) in
            self.resultContactFieldId = params[0] as? NSNumber
            self.resultContactFieldValue = params[1] as? String
            self.predictWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          mobileEngage: self.fakeMobileEngageApi,
                                                          loggingMobileEngage: self.fakeLoggingME,
                                                          predict: self.fakePredict)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.predictConfig)
        
        try await SwiftEmarsys.setContact(self.contactFieldId, self.contactFieldValue)
        
        XCTAssertEqual(self.resultContactFieldId, self.contactFieldId)
        XCTAssertEqual(self.resultContactFieldValue, self.contactFieldValue)
        XCTAssertTrue(self.predictWasCalled)
        XCTAssertFalse(self.meWasCalled)
        XCTAssertFalse(self.meLoggingWasCalled)
    }
    
    
    func testSetContact_shouldDelegateCallToInternalInstance() async throws {
        let container = await EmarsysContainer(mobileEngageConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.resultContactFieldId = params[0] as? NSNumber
            self.resultContactFieldValue = params[1] as? String
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          mobileEngage: self.fakeMobileEngageApi)
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        try await SwiftEmarsys.setContact(self.contactFieldId, self.contactFieldValue)
        
        XCTAssertEqual(self.resultContactFieldId, self.contactFieldId)
        XCTAssertEqual(self.resultContactFieldValue, self.contactFieldValue)
    }
    
    func testClearContact_shouldDelegateCallToInternalInstance() async throws {
        let container = await EmarsysContainer(mobileEngageConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.meWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          mobileEngage: self.fakeMobileEngageApi)
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        try await SwiftEmarsys.clearContact()
        
        XCTAssertTrue(self.meWasCalled)
    }
    
    func testClearContact_shouldDelegateCallToPredictInstanceButNotMobileEngage() async throws {
        let container = await EmarsysContainer(self.predictConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.meWasCalled = true
        }
        
        fakeLoggingME.callHandler = { [unowned self] (_ params: Any?...) in
            self.meLoggingWasCalled = true
        }
        
        fakePredict.callHandler = { [unowned self] (_ params: Any?...) in
            self.predictWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          deviceInfoClient: self.fakeDeviceInfoClient,
                                                          mobileEngage: self.fakeMobileEngageApi,
                                                          loggingMobileEngage: self.fakeLoggingME,
                                                          predict: self.fakePredict)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.predictConfig)
        
        try await SwiftEmarsys.clearContact()
        
        XCTAssertTrue(self.predictWasCalled)
        XCTAssertFalse(self.meWasCalled)
        XCTAssertFalse(self.meLoggingWasCalled)
    }
    
    func testClearContact_shouldDelegateCallToLoggingInstanceButNotPredict() async throws {
        let container = await EmarsysContainer(self.emptyConfig)
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            self.meWasCalled = true
        }
        
        fakeLoggingME.callHandler = { [unowned self] (_ params: Any?...) in
            self.meLoggingWasCalled = true
        }
        
        fakeLoggingPredict.callHandler = { [unowned self] (_ params: Any?...) in
            self.predictLoggingWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          deviceInfoClient: self.fakeDeviceInfoClient,
                                                          mobileEngage: self.fakeMobileEngageApi,
                                                          loggingMobileEngage: self.fakeLoggingME,
                                                          loggingPredict: self.fakeLoggingPredict)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.emptyConfig)
        
        try await SwiftEmarsys.clearContact()
        
        XCTAssertTrue(self.meLoggingWasCalled)
        XCTAssertFalse(self.predictLoggingWasCalled)
    }
    
    func testTrackCustomEvent_shouldDelegateCallToMobileEngageInstance() async throws {
        let container = await EmarsysContainer(self.mobileEngageConfig)
        let eventName = "testEventName"
        let eventAttributes = ["testKey": "testValue"]
        var resultEventName: String? = nil
        var resultEventAttributes: [String: String]? = nil
        
        fakeMobileEngageApi.callHandler = { [unowned self] (_ params: Any?...) in
            resultEventName = params[0] as? String
            resultEventAttributes = params[1] as? [String: String]
            self.meWasCalled = true
        }
        
        
        let fakeContainer = await FakeDependencyContainer(container: container,
                                                          mobileEngage: self.fakeMobileEngageApi)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        try await SwiftEmarsys.trackCustomEvent(eventName, eventAttributes: eventAttributes)
        
        XCTAssertEqual(resultEventName, eventName)
        XCTAssertEqual(resultEventAttributes, eventAttributes)
        XCTAssertTrue(self.meWasCalled)
    }
    
    func testDeepLink_shouldDelegateCallToDeepLinkInstance() async throws {
        let container = await EmarsysContainer(self.mobileEngageConfig)
        
        let userActivity = NSUserActivity(activityType: "testType")
        var resultUserActivty: NSUserActivity? = nil
        var deepLinkWasCalled = false
        
        self.fakeDeepLinkApi.callHandler = { (_ params: Any?...) in
            resultUserActivty = params[0] as? NSUserActivity
            deepLinkWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container, deepLink: fakeDeepLinkApi)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        try await SwiftEmarsys.trackDeepLink(userActivity)
        
        XCTAssertEqual(resultUserActivty, userActivity)
        XCTAssertTrue(deepLinkWasCalled)
    }
}
