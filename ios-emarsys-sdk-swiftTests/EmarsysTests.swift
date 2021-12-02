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
    
    override func setUp() {
        super.setUp()
        self.mobileEngageConfig = Config(applicationCode: "EMS11-C3FD3",
                                         experimentalFeatures: nil,
                                         enabledConsoleLogLevels: nil,
                                         merchantId: nil,
                                         sharedKeychainAccessGroup: nil)
        
        self.predictConfig = Config(applicationCode: nil,
                                    experimentalFeatures: nil,
                                    enabledConsoleLogLevels: nil,
                                    merchantId: "testMerchantId",
                                    sharedKeychainAccessGroup: nil)
        
    }
    
    override func tearDown() {
        DependencyInjection.teardown()
        teardownEmarsys()
    }
    
    func testSetup_shouldEnableMobileEngageAndEventServiceV4_whenApplicationCodeIsAvailableInConfig() async throws {
        try await SwiftEmarsys.setup(mobileEngageConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldPredict_whenMerchantIdIsAvailableInConfig() async throws {
        try await SwiftEmarsys.setup(predictConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_mobileEngageAndEventServiceV4FeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await SwiftEmarsys.setup(Config(applicationCode: "",
                                       experimentalFeatures: nil,
                                       enabledConsoleLogLevels: nil,
                                       merchantId: "testMerchantId",
                                       sharedKeychainAccessGroup: nil))
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_PredictFeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await SwiftEmarsys.setup(mobileEngageConfig)
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }

    func testSetup_shouldSetupDependencyContainer() async throws {
        try await SwiftEmarsys.setup(mobileEngageConfig)
        var result: EmarsysDependency? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = try await DependencyInjection.dependencyContainer()
        }

        XCTAssertNotNil(result)
    }

    func testConfig_shouldReturnConfig() async throws {
        var result: ConfigApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.config
        }

        XCTAssertNotNil(result)
    }
    
    func testPush_shouldReturnPushInternal() async throws {
        var result: PushApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.push
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushInternal)
    }
    
    
    func testPush_shouldReturnPushLogger() async throws {
        var result: PushApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.push
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushLogger)
    }
    
    func testPush_shouldReturnInboxInternal() async throws {
        var result: InboxApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.inbox
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxInternal)
    }
    
    
    func testPush_shouldReturnInboxLogger() async throws {
        var result: InboxApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.inbox
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxLogger)
    }
    
    func testPush_shouldReturnInAppInternal() async throws {
        var result: InAppApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.inApp
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppInternal)
    }
    
    
    func testPush_shouldReturnInAppLogger() async throws {
        var result: InAppApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.inApp
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppLogger)
    }
    
    func testPush_shouldReturnGeofenceInternal() async throws {
        var result: GeofenceApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.geofence
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceInternal)
    }
    
    
    func testPush_shouldReturnGeofenceLogger() async throws {
        var result: GeofenceApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.geofence
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceLogger)
    }
    
    func testPush_shouldReturnPredictInternal() async throws {
        var result: PredictApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.predict
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictInternal)
    }
    
    
    func testPush_shouldReturnPredictLogger() async throws {
        var result: PredictApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.predict
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictLogger)
    }
    
    func testPush_shouldReturnOnEventActionInternal() async throws {
        var result: OnEventActionApi? = nil

        do {
            try await SwiftEmarsys.setup(mobileEngageConfig)
            result = await SwiftEmarsys.onEventAction
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionInternal)
    }
    
    
    func testPush_shouldReturnOnEventActionLogger() async throws {
        var result: OnEventActionApi? = nil

        do {
            try await SwiftEmarsys.setup(predictConfig)
            result = await SwiftEmarsys.onEventAction
        }

        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionLogger)
    }
}
