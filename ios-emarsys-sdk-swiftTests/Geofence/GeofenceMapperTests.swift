//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class GeofenceMapperTests: XCTestCase {

    var mapper: GeofenceMapper!

    override func setUp() {
        super.setUp()
        mapper = GeofenceMapper()
    }

    func testMap_withEmptyInput() throws {
        let expectation: [Geofence] = []
        let geofences: [EMSGeofence] = []

        let result = self.mapper.map(geofences)

        XCTAssertEqual(NSArray(array: result),
                NSArray(array: expectation))
    }

    func testMap() throws {
        let actionDictionary: [String: Any] = [
            "id": "testId",
            "type": "MECustomEvent",
            "name": "testName",
            "payload": ["key": "value"]
        ]

        let geofence1 = EMSGeofence(
                id: "testGeofenceId",
                lat: 12.34,
                lon: 56.78,
                r: 30,
                waitInterval: 90.12,
                triggers: [
                    EMSGeofenceTrigger(
                            id: "testTriggerId",
                            type: "ENTER",
                            loiteringDelay: 123,
                            action: actionDictionary
                    )
                ]
        )

        let geofence2 = EMSGeofence(
                id: "testGeofenceId2",
                lat: 12.34,
                lon: 56.78,
                r: 30,
                waitInterval: 90.12,
                triggers: [
                    EMSGeofenceTrigger(
                            id: "testTriggerId2",
                            type: "EXIT",
                            loiteringDelay: 456,
                            action: [String: Any]()
                    )
                ]
        )

        let expectation1 = Geofence(id: "testGeofenceId",
                lat: 12.34,
                lon: 56.78,
                radius: 30,
                waitInterval: 90.12,
                triggers: [
                    Trigger(
                            id: "testTriggerId",
                            type: TriggerType.enter,
                            loiteringDelay: 123,
                            action: actionDictionary
                    )
                ])

        let expectation2 = Geofence(id: "testGeofenceId2",
                lat: 12.34,
                lon: 56.78,
                radius: 30,
                waitInterval: 90.12,
                triggers: [
                    Trigger(
                            id: "testTriggerId2",
                            type: TriggerType.exit,
                            loiteringDelay: 456,
                            action: [String: Any]()
                    )
                ])

        let result = mapper.map([geofence1!, geofence2!])

        XCTAssertEqual(result, [expectation1, expectation2])
    }
}
