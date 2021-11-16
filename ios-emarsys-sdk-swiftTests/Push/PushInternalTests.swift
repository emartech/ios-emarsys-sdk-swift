//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class PushInternalTests: XCTestCase {

    var fakeEMSPush: FakeEMSPush!
    var pushInternal: PushInternal!
    var pushTokenValue: Data = Data()
    var userInfo: [String: Any]!
    var eventPublisher: EventPublisher = EventPublisher()
    var notificationInformationPublisher: NotificationInformationPublisher = NotificationInformationPublisher()


    override func setUp() {
        super.setUp()
        fakeEMSPush = FakeEMSPush()
        pushInternal = PushInternal(emsPush: fakeEMSPush, delegate: nil, silentNotificationEventPublisher: eventPublisher, silentNotificationInformationPublisher: notificationInformationPublisher, notificationEventPublisher: eventPublisher, notificationInformationPublisher: notificationInformationPublisher)
    }

    func testSetPushToken() async throws {
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        try await self.pushInternal.setPushToken(pushTokenValue)

        XCTAssertTrue(isCalled)
    }

    func testSetPushToken_withError() async throws {
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorSetToken")

        do {
            _ = try await self.pushInternal.setPushToken(pushTokenValue)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorSetToken")
        }

        XCTAssertTrue(isCalled)
    }

    func testClearPushToken() async throws {
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        try await self.pushInternal.clearPushToken()

        XCTAssertTrue(isCalled)
    }

    func testClearPushToken_withError() async throws {
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorClearToken")

        do {
            _ = try await self.pushInternal.clearPushToken()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorClearToken")
        }

        XCTAssertTrue(isCalled)
    }

    func testTrackMessageOpen() async throws {
        userInfo = ["name": "Bela"]
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        try await self.pushInternal.trackMessageOpen(userInfo)
        XCTAssertTrue(isCalled)
    }

    func testTrackMessageOpen_withError() async throws {
        userInfo = ["name": "Bela"]
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorTrackMessegaOpen")

        do {
            _ = try await self.pushInternal.clearPushToken()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorTrackMessegaOpen")
        }

        XCTAssertTrue(isCalled)
    }

    func testHandleMessage() async throws {
        userInfo = ["name": "Bela"]
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        await self.pushInternal.handleMessage(userInfo)
        XCTAssertTrue(isCalled)
    }

    func testHandleMessage_withError() async throws {
        userInfo = ["name": "Bela"]
        var isCalled: Bool = false

        fakeEMSPush.callHandler = {
            isCalled = true
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorHandleMessage")

        do {
            _ = try await self.pushInternal.clearPushToken()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorHandleMessage")
        }

        XCTAssertTrue(isCalled)
    }
}
