//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class ConfigInternalTests: XCTestCase {

    var fakeEMSConfig: FakeEMSConfig!
    var configInternal: ConfigInternal!
    var testApplicationCodeValue: String = "testApplicationCode"
    var testMerchantIdValue: String = "testMerchantId"

    override func setUp() {
        super.setUp()
        fakeEMSConfig = FakeEMSConfig()
        configInternal = ConfigInternal(emsConfig: fakeEMSConfig)
    }

    func testApplicationCode() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.applicationCode, "testApplicationCode")

        XCTAssertTrue(isCalled)
    }

    func testMerchantId() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.merchantId, "testMerchantId")

        XCTAssertTrue(isCalled)
    }

    func testContactFieldId() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.contactFieldId, 2)

        XCTAssertTrue(isCalled)
    }

    func testHardwareId() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.hardwareId, "testHardwareId")

        XCTAssertTrue(isCalled)
    }

    func testLanguageCode() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.languageCode, "testLanguageCode")

        XCTAssertTrue(isCalled)
    }

    func testPushSettings() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.pushSettings["test"] as? String?, "push")
        XCTAssertEqual(self.configInternal.pushSettings.count, 1)

        XCTAssertTrue(isCalled)
    }

    func testSdkVersion() {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        XCTAssertEqual(self.configInternal.sdkVersion, "testSdkVersionValue")

        XCTAssertTrue(isCalled)
    }

    func testChangeApplicationCode() async throws {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        fakeEMSConfig.error = nil

        try await self.configInternal.changeApplicationCode(testApplicationCodeValue)

        XCTAssertTrue(isCalled)
    }

    func testChangeApplicationCode_withError() async throws {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        fakeEMSConfig.error = NSError(code: 42, localizedDescription: "testErrorChangeApplicationCode")

        do {
            _ = try await self.configInternal.changeApplicationCode(testApplicationCodeValue)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorChangeApplicationCode")
        }

        XCTAssertTrue(isCalled)
    }

    func testChangeMerchantId() async throws {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        fakeEMSConfig.error = nil

        try await self.configInternal.changeMerchantId(testMerchantIdValue)

        XCTAssertTrue(isCalled)
    }

    func testChangeMerchantId_withError() async throws {
        var isCalled: Bool = false

        fakeEMSConfig.callHandler = {
            isCalled = true
        }

        fakeEMSConfig.error = NSError(code: 42, localizedDescription: "testErrorChangeMerchantId")

        do {
            _ = try await self.configInternal.changeMerchantId(testMerchantIdValue)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorChangeMerchantId")
        }
        XCTAssertTrue(isCalled)
    }
}

