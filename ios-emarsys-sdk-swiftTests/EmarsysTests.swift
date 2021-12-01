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
        try await Emarsys.setup(mobileEngageConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_shouldPredict_whenMerchantIdIsAvailableInConfig() async throws {
        try await Emarsys.setup(predictConfig)
        
        XCTAssertTrue(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
    
    func testSetup_mobileEngageAndEventServiceV4FeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await Emarsys.setup(Config(applicationCode: "",
                                       experimentalFeatures: nil,
                                       enabledConsoleLogLevels: nil,
                                       merchantId: "testMerchantId",
                                       sharedKeychainAccessGroup: nil))
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage))
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.eventServiceV4))
    }
    
    func testSetup_PredictFeatureShouldNotBeEnabled_whenConfigDoesNotContainsNeededData() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        
        XCTAssertFalse(MEExperimental.isFeatureEnabled(EMSInnerFeature.predict))
    }
}
