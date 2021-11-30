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

        fakeEMSInApp.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        await self.inAppInternal.pause()

        XCTAssertTrue(isCalled)
    }

    func testResume() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        await self.inAppInternal.resume()

        XCTAssertTrue(isCalled)
    }

    func testIsPaused() async {
        var isCalled: Bool = false

        fakeEMSInApp.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        XCTAssertTrue(self.inAppInternal.isPaused)
        XCTAssertTrue(isCalled)

    }

    func testEventHandler() {
        var eventName = ""
        var eventPayload: [String: Any?]? = [:]

        self.inAppInternal.eventHandler = { name, payload in
            eventName = name
            eventPayload = payload
        }

        fakeEMSInApp.eventHandler("testName", ["test": "payload"])

        XCTAssertEqual(eventName, "testName")
        XCTAssertEqual(eventPayload as! [String: String], ["test": "payload"])
    }

    func testEventStream() {
        var testName = ""
        var testPayload: [String: String] = [:]

        let cancellable = self.inAppInternal.eventStream.sink { error in
            print(error)
        } receiveValue: { event in
            testName = event.name
            testPayload = event.payload as! [String: String]
        }

        fakeEMSInApp.eventHandler("testName", ["test": "payload"])

        XCTAssertEqual("testName", testName)
        XCTAssertEqual("payload", testPayload["test"])
        cancellable.cancel()
    }
}
