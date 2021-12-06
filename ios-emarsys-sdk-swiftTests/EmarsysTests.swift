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
    let contactFieldId = NSNumber(integerLiteral: 2575)
    let contactFieldValue = "testContactFieldValue"
    let openIdToken = "testOpenIdToken"
    
    var fakeMobileEngageApi = FakeMobileEngageApi()
    var fakeLoggingME = FakeMobileEngageApi()
    var fakePredict = FakePredictApi()
    var fakeLoggingPredict = FakePredictApi()
    
    var resultContactFieldId: NSNumber? = nil
    var resultContactFieldValue: String? = nil
    var resultOpenIdToken: String? = nil
    
    var meWasCalled = false
    var meLoggingWasCalled = false
    var predictWasCalled = false
    var predictLoggingWasCalled = false
    
    override func setUp() {
        super.setUp()
        self.mobileEngageConfig = Config(applicationCode: "testAppCode")
        
        self.predictConfig = Config(merchantId: "testMerchantId")
        
        self.emptyConfig = Config()
        
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
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldPredict_whenMerchantIdIsAvailableInConfig() async throws {
        try await SwiftEmarsys.setup(self.predictConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_mobileEngageAndEventServiceV4FeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await SwiftEmarsys.setup(Config(merchantId: "testMerchantId"))
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_PredictFeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_shouldSetupDependencyContainer() async throws {
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        var result: EmarsysDependency? = nil
        
        do {
            try await SwiftEmarsys.setup(self.mobileEngageConfig)
            result = try await DependencyInjection.dependencyContainer()
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
        var result: PredictApi? = nil
        
        do {
            try await SwiftEmarsys.setup(self.predictConfig)
            result = await SwiftEmarsys.predict
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictInternal)
    }
    
    
    func testPush_shouldReturnPredictLogger() async throws {
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
    
    func testSetAuthenticatedContact_shouldDelegateCallToInternalInstanceAndDisablePredict() async throws {
        let allFeatureConfig = Config(applicationCode: "testAppCode",
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
        var fakeDeepLink = FakeDeepLinkApi()
        
        let userActivity = NSUserActivity(activityType: "testType")
        var resultUserActivty: NSUserActivity? = nil
        var deepLinkWasCalled = false
        
        fakeDeepLink.callHandler = { (_ params: Any?...) in
            resultUserActivty = params[0] as? NSUserActivity
            deepLinkWasCalled = true
        }
        
        let fakeContainer = await FakeDependencyContainer(container: container, deepLink: fakeDeepLink)
        
        DependencyInjection.setup(fakeContainer)
        
        try await SwiftEmarsys.setup(self.mobileEngageConfig)
        
        try await SwiftEmarsys.trackDeepLink(userActivity)
        
        XCTAssertEqual(resultUserActivty, userActivity)
        XCTAssertTrue(deepLinkWasCalled)
    }
}
