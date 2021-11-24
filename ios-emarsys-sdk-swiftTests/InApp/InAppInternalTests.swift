//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
import Combine
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class InAppInternalTests: XCTestCase {

    var fakeEMSInApp: FakeEMSInApp!
    var inAppInternal: InAppInternal!
    var eventStream: PassthroughSubject<Event, Error>!

    override func setUp() {
        super.setUp()
        fakeEMSInApp = FakeEMSInApp()
        eventStream = PassthroughSubject<Event, Error>()
        inAppInternal = InAppInternal(emsInApp: fakeEMSInApp, eventStream: eventStream)
    }

    func testPause() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = { (_ param: Any?...) in isCalled = true }

        await self.inAppInternal.pause()

        XCTAssertTrue(isCalled)
    }

    func testResume() async {
        var isCalled: Bool = false
        
        fakeEMSInApp.callHandler = { (_ param: Any?...) in isCalled = true }

        await self.inAppInternal.resume()

        XCTAssertTrue(isCalled)
    }

    func testIsPaused() async {
        var isCalled: Bool = false
        
        fakeEMSInApp.callHandler = { (_ param: Any?...) in isCalled = true }

        XCTAssertTrue(self.inAppInternal.isPaused)
        XCTAssertTrue(isCalled)

    }
}
