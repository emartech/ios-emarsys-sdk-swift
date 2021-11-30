//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
import Combine
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class OnEventActionTests: XCTestCase {

    var onEventActionInternal: OnEventActionInternal!
    var fakeEMSOnEventAction: FakeEMSOnEventAction!
    var eventStream: PassthroughSubject<Event, Error>!

    override func setUp() {
        super.setUp()
        fakeEMSOnEventAction = FakeEMSOnEventAction()
        eventStream = PassthroughSubject<Event, Error>()
        onEventActionInternal = OnEventActionInternal(emsOnEventAction: fakeEMSOnEventAction, eventStream: eventStream)
    }

    func testEventHandler() {
        var eventName = ""
        var eventPayload: [String: Any?]? = [:]

        self.onEventActionInternal.eventHandler = { name, payload in
            eventName = name
            eventPayload = payload
        }

        fakeEMSOnEventAction.eventHandler?("testName", ["test": "payload"])

        XCTAssertEqual(eventName, "testName")
        XCTAssertEqual(eventPayload as! [String: String], ["test": "payload"])
    }

    func testEventStream() {
        var testName = ""
        var testPayload: [String: String] = [:]

        let cancellable = self.onEventActionInternal.eventStream.sink { error in
            print(error)
        } receiveValue: { event in
            testName = event.name
            testPayload = event.payload as! [String: String]
        }

        fakeEMSOnEventAction.eventHandler?("testName", ["test": "payload"])

        XCTAssertEqual("testName", testName)
        XCTAssertEqual("payload", testPayload["test"])
        cancellable.cancel()
    }
}
