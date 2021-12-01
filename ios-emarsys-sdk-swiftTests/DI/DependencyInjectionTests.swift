//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
import Combine
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class DependencyInjectionTests: XCTestCase {
    
    var emptyConfig: Config!
    var mobileEngageConfig: Config!
    var predictConfig: Config!
    
    override func setUp() {
        super.setUp()
        self.emptyConfig = Config(applicationCode: "",
                                  experimentalFeatures: nil,
                                  enabledConsoleLogLevels: nil,
                                  merchantId: nil,
                                  sharedKeychainAccessGroup: nil)
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
    
    func testSetup_shouldSetupContainer() async throws {
        let container = await EmarsysContainer(mobileEngageConfig)
        DependencyInjection.setup(container)
        
        var result: EmarsysContainer? = nil
        
        do {
            result = try await DependencyInjection.dependencyContainer() as? EmarsysContainer
        }
        catch {
            print(error)
        }
        
        try assertField(of: result!, with: "setupConfig", isEqual: mobileEngageConfig)
    }
    
    func testSetup_shouldNotOverwriteExistingContainer() async throws {
        let meContainer = await EmarsysContainer(mobileEngageConfig)
        let predictContainer = await EmarsysContainer(predictConfig)
        DependencyInjection.setup(meContainer)
        DependencyInjection.setup(predictContainer)
        
        var result: EmarsysContainer? = nil
        
        do {
            result = try await DependencyInjection.dependencyContainer() as? EmarsysContainer
        }
        catch {
            print(error)
        }
        
        try assertField(of: result!, with: "setupConfig", isEqual: mobileEngageConfig)
    }
    
    func testTearDown_shouldSetContainerToNil() async throws {
        let meContainer = await EmarsysContainer(mobileEngageConfig)
        DependencyInjection.setup(meContainer)
        
        DependencyInjection.teardown()
        
        do {
            let _ = try await DependencyInjection.dependencyContainer()
        } catch {
            XCTAssertEqual(error as! SetupError, .dependencyContainer)
        }
    }
    
    
    func testDependencyContainerShouldThrowErrorWhenContainerIsNil() async throws {
        do {
            _ = try await DependencyInjection.dependencyContainer()
        }
        catch {
            XCTAssertEqual(error as? SetupError, .dependencyContainer)
        }
    }
    
    func testMobileEngage_shouldThrowErrorWhenDependencyContainerIsNotSetup() async throws {
        do {
            _ = try await DependencyInjection.mobileEngage()
        }
        catch {
            XCTAssertEqual(error as? SetupError, .dependencyContainer)
        }
    }
    
    func testMobileEngage_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: MobileEngageApi? = nil
        do {
            result = try await DependencyInjection.mobileEngage()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is MobileEngageInternal)
    }
    
    func testMobileEngage_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: MobileEngageApi? = nil
        do {
            result = try await DependencyInjection.mobileEngage()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is MobileEngageLogger)
    }
    
    func testPush_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: PushApi? = nil
        do {
            result = try await DependencyInjection.push()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushInternal)
    }
    
    func testPush_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: PushApi? = nil
        do {
            result = try await DependencyInjection.push()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PushLogger)
    }
    
    func testDeepLink_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: DeepLinkApi? = nil
        do {
            result = try await DependencyInjection.deepLink()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is DeepLinkInternal)
    }
    
    func testDeepLink_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: DeepLinkApi? = nil
        do {
            result = try await DependencyInjection.deepLink()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is DeepLinkLogger)
    }
    
    func testInApp_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: InAppApi? = nil
        do {
            result = try await DependencyInjection.inApp()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppInternal)
    }
    
    func testInApp_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: InAppApi? = nil
        do {
            result = try await DependencyInjection.inApp()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InAppLogger)
    }
    
    func testGeofence_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: GeofenceApi? = nil
        do {
            result = try await DependencyInjection.geofence()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceInternal)
    }
    
    func testGeofence_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: GeofenceApi? = nil
        do {
            result = try await DependencyInjection.geofence()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is GeofenceLogger)
    }
    
    func testInBox_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: InboxApi? = nil
        do {
            result = try await DependencyInjection.inbox()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxInternal)
    }
    
    func testInbox_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: InboxApi? = nil
        do {
            result = try await DependencyInjection.inbox()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is InboxLogger)
    }
    
    func testOnEventAction_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(mobileEngageConfig)
        await DependencyInjection.setup(EmarsysContainer(mobileEngageConfig))
        
        var result: OnEventActionApi? = nil
        do {
            result = try await DependencyInjection.onEventAction()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionInternal)
    }
    
    func testOnEventAction_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: OnEventActionApi? = nil
        do {
            result = try await DependencyInjection.onEventAction()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is OnEventActionLogger)
    }
    
    func testPredict_shouldReturnInternalInstanceWhenFeatureIsEnabled() async throws {
        try await Emarsys.setup(predictConfig)
        await DependencyInjection.setup(EmarsysContainer(predictConfig))
        
        var result: PredictApi? = nil
        do {
            result = try await DependencyInjection.predict()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictInternal)
    }
    
    func testPredict_shouldReturnLoggingInstanceWhenFeatureIsNotEnabled() async throws {
        let config = Config(applicationCode: "", experimentalFeatures: nil, enabledConsoleLogLevels: nil, merchantId: nil, sharedKeychainAccessGroup: nil)
        try await Emarsys.setup(config)
        await DependencyInjection.setup(EmarsysContainer(config))
        
        var result: PredictApi? = nil
        do {
            result = try await DependencyInjection.predict()
        }
        catch {
        }
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result is PredictLogger)
    }
}
