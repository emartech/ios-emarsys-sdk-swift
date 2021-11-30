//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
import Combine
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class GeofenceInternalTests: XCTestCase {

    var geofenceInternal: GeofenceInternal!
    var fakeEmsGeofence: FakeEMSGeofence!
    var geofenceMapper: GeofenceMapper!
    var enabledValue: Bool = true
    var eventStream: PassthroughSubject<Event, Error>!

    override func setUp() {
        super.setUp()
        geofenceMapper = GeofenceMapper()
        fakeEmsGeofence = FakeEMSGeofence()
        eventStream = PassthroughSubject<Event, Error>()
        geofenceInternal = GeofenceInternal(emsGeofence: fakeEmsGeofence, geofenceMapper: geofenceMapper, eventStream: eventStream)
    }

    func testIsEnabled() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        XCTAssertTrue(self.geofenceInternal.isEnabled)

        XCTAssertTrue(isCalled)
    }

    func testDisable() async {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        await self.geofenceInternal.disable()

        XCTAssertTrue(isCalled)
    }

    func testEnable() async throws {
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }

        try await self.geofenceInternal.enable()

        XCTAssertNotNil(completionBlock)
        XCTAssertTrue(isCalled)
    }

    func testEnable_withError() async throws {
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }

        fakeEmsGeofence.error = NSError(code: 42, localizedDescription: "testErrorEnable")

        do {
            _ = try await self.geofenceInternal.enable()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorEnable")
        }

        XCTAssertNotNil(completionBlock)
        XCTAssertTrue(isCalled)
    }

    func testRegisteredGeofences() async {
        var isCalled: Bool = false
        var geofences: [EMSGeofence] = []
        let geofence = EMSGeofence(id: "testGeofence", lat: 47.4, lon: 27.5, r: 300, waitInterval: 50.3, triggers: [])
        geofences.append(geofence!)

        fakeEmsGeofence.geofences = geofences

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        let expectedGeofences = [Geofence(id: "testGeofence", lat: 47.4, lon: 27.5, radius: 300, waitInterval: 50.3, triggers: [])]

        let result = await self.geofenceInternal.registeredGeofences()

        XCTAssertEqual(result, expectedGeofences)

        XCTAssertTrue(isCalled)
    }

    func testInitialTriggerEnabled_get() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        let result = self.geofenceInternal.initialEnterTriggerEnabled

        XCTAssertTrue(isCalled)
        XCTAssertTrue(result)
    }

    func testInitialTriggerEnabled_set() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        self.geofenceInternal.initialEnterTriggerEnabled = false

        XCTAssertTrue(isCalled)
    }

    func testRequestalwaysAuthoruzation() async {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = { (_ param: Any?...) in
            isCalled = true
        }

        await self.geofenceInternal.requestAlwaysAuthorization()

        XCTAssertTrue(isCalled)
    }

    func testEventHandler() {
        var eventName = ""
        var eventPayload: [String: Any?]? = [:]

        self.geofenceInternal.eventHandler = { name, payload in
            eventName = name
            eventPayload = payload
        }

        fakeEmsGeofence.eventHandler("testName", ["test": "payload"])

        XCTAssertEqual(eventName, "testName")
        XCTAssertEqual(eventPayload as! [String: String], ["test": "payload"])
    }

    func testEventStream() {
        var testName = ""
        var testPayload: [String: String] = [:]

        let cancellable = self.geofenceInternal.eventStream.sink { error in
            print(error)
        } receiveValue: { event in
            testName = event.name
            testPayload = event.payload as! [String: String]
        }

        fakeEmsGeofence.eventHandler("testName", ["test": "payload"])

        XCTAssertEqual("testName", testName)
        XCTAssertEqual("payload", testPayload["test"])
        cancellable.cancel()
    }
}
