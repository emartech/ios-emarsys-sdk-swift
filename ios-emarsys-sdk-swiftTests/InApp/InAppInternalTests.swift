//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class InAppInternalTests: XCTestCase {

    var fakeEMSInApp: FakeEMSInApp!
    var inAppInternal: InAppInternal!

    override func setUp() {
        super.setUp()
        fakeEMSInApp = FakeEMSInApp()
        inAppInternal = InAppInternal(emsInApp: fakeEMSInApp)
    }

    func testPause() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = {
            isCalled = true
        }

        await self.inAppInternal.pause()

        XCTAssertTrue(isCalled)
    }

    func testResume() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = {
            isCalled = true
        }

        await self.inAppInternal.resume()

        XCTAssertTrue(isCalled)
    }

    func testIsPaused() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = {
            isCalled = true
        }

        XCTAssertTrue(self.inAppInternal.isPaused)

        XCTAssertTrue(isCalled)

    }

}
