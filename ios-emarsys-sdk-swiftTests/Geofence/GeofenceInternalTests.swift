//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class GeofenceInternalTests: XCTestCase {

    var geofenceInternal: GeofenceInternal!
    var fakeEmsGeofence: FakeEMSGeofence!
    var geofenceMapper: GeofenceMapper!
    var enabbledValue: Bool = true

    override func setUp() {
        super.setUp()
        geofenceMapper = GeofenceMapper()
        fakeEmsGeofence = FakeEMSGeofence()
        geofenceInternal = GeofenceInternal(emsGeofence: fakeEmsGeofence, geofenceMapper: geofenceMapper)
    }

    func testIsEnabled() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        XCTAssertTrue(self.geofenceInternal.isEnabled)

        XCTAssertTrue(isCalled)
    }

    func testDisable() async {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        await self.geofenceInternal.disable()

        XCTAssertTrue(isCalled)
    }

    func testEnable() async throws {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        try await self.geofenceInternal.enable()

        XCTAssertTrue(isCalled)
    }

    func testEnable_withError() async throws {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        fakeEmsGeofence.error = NSError(code: 42, localizedDescription: "testErrorEnable")

        do {
            _ = try await self.geofenceInternal.enable()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorEnable")
        }

        XCTAssertTrue(isCalled)
    }

    func testRegisteredGeofences() async {
        var isCalled: Bool = false
        var geofences: [EMSGeofence] = []
        let geofence = EMSGeofence(id: "testGeofence", lat: 47.4, lon: 27.5, r: 300, waitInterval: 50.3, triggers: [])
        geofences.append(geofence!)

        fakeEmsGeofence.geofences = geofences
        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        var expectedGeofences = [Geofence(id: "testGeofence", lat: 47.4, lon: 27.5, radius: 300, waitInterval: 50.3, triggers: [])]

        var result = await self.geofenceInternal.registeredGeofences()

        XCTAssertEqual(result, expectedGeofences)

        XCTAssertTrue(isCalled)
    }

    func testInitialTriggerEnabled_get() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        let result = self.geofenceInternal.initialEnterTriggerEnabled

        XCTAssertTrue(isCalled)
        XCTAssertTrue(result)
    }

    func testInitialTriggerEnabled_set() {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        self.geofenceInternal.initialEnterTriggerEnabled = false

        XCTAssertTrue(isCalled)
    }

    func testRequestalwaysAuthoruzation() async {
        var isCalled: Bool = false

        fakeEmsGeofence.callHandler = {
            isCalled = true
        }

        await self.geofenceInternal.requestAlwaysAuthorization()

        XCTAssertTrue(isCalled)
    }
}