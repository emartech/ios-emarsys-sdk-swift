//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed
import Combine

class PushInternalTests: XCTestCase {
    var fakeEMSPush: FakeEMSPush!
    var pushInternal: PushInternal!
    var pushTokenValue: Data = Data()
    var userInfo: [String: Any]!
    var silentNotificationEventStream: PassthroughSubject<Event, Error>!
    var silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>!
    var notificationEventStream: PassthroughSubject<Event, Error>!
    var notificationInformationStream: PassthroughSubject<NotificationInformation, Error>!


    override func setUp() {
        super.setUp()
        fakeEMSPush = FakeEMSPush()
        pushInternal = PushInternal(emsPush: fakeEMSPush,
                silentNotificationEventStream: PassthroughSubject<Event, Error>(),
                silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>(),
                notificationEventStream: PassthroughSubject<Event, Error>(),
                notificationInformationStream: PassthroughSubject<NotificationInformation, Error>())
    }

    func testSetPushToken() async throws {
        var isCalled: Bool = false
        var testToken: Data? = nil
        var completionBlock: EMSCompletionBlock? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            testToken = (param[0] as! Data)
            completionBlock = (param[1] as! EMSCompletionBlock)
        }

        try await self.pushInternal.setPushToken(pushTokenValue)

        XCTAssertNotNil(completionBlock)
        XCTAssertNotNil(testToken)
        XCTAssertTrue(isCalled)
    }

    func testSetPushToken_withError() async throws {
        var isCalled: Bool = false
        var testToken: Data? = nil
        var completionBlock: EMSCompletionBlock? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            testToken = (param[0] as! Data)
            completionBlock = (param[1] as! EMSCompletionBlock)
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorSetToken")

        do {
            _ = try await self.pushInternal.setPushToken(pushTokenValue)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorSetToken")
        }

        XCTAssertNotNil(completionBlock)
        XCTAssertNotNil(testToken)
        XCTAssertTrue(isCalled)
    }

    func testClearPushToken() async throws {
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }

        try await self.pushInternal.clearPushToken()

        XCTAssertTrue(isCalled)
        XCTAssertNotNil(completionBlock)
    }

    func testClearPushToken_withError() async throws {
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil
        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }
        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorClearToken")
        do {
            _ = try await self.pushInternal.clearPushToken()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorClearToken")
        }
        XCTAssertTrue(isCalled)
        XCTAssertNotNil(completionBlock)
    }

    func testTrackMessageOpen() async throws {
        userInfo = ["name": "TestName"]
        var expectedInfo: [String: Any]? = nil
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            expectedInfo = (param[0] as! [String: Any])
            completionBlock = (param[1] as! EMSCompletionBlock)
        }

        try await self.pushInternal.trackMessageOpen(userInfo)

        XCTAssertTrue(isCalled)
        XCTAssertEqual(expectedInfo?["name"] as! String, "TestName")
        XCTAssertNotNil(completionBlock)
    }

    func testTrackMessageOpen_withError() async throws {
        userInfo = ["name": "TestName"]
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil
        var expectedInfo: [String: Any]? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            expectedInfo = (param[0] as! [String: Any])
            completionBlock = (param[1] as! EMSCompletionBlock)
        }

        fakeEMSPush.error = NSError(code: 42, localizedDescription: "testErrorTrackMessegaOpen")

        do {
            _ = try await self.pushInternal.trackMessageOpen(userInfo)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorTrackMessegaOpen")
        }

        XCTAssertTrue(isCalled)
        XCTAssertEqual(expectedInfo?["name"] as! String, "TestName")
        XCTAssertNotNil(completionBlock)
    }

    func testHandleMessage() async throws {
        userInfo = ["name": "TestName"]
        var isCalled: Bool = false
        var expectedInfo: [String: Any]? = nil

        fakeEMSPush.callHandler = { (_ param: Any?...) in
            isCalled = true
            expectedInfo = (param[0] as! [String: Any])
        }

        await self.pushInternal.handleMessage(userInfo)

        XCTAssertTrue(isCalled)
        XCTAssertEqual(expectedInfo?["name"] as! String, "TestName")
    }

    func testSilentNotificationEventHandler() {
        var eventName = ""
        var eventPayload: [String: Any?]? = [:]

        self.pushInternal.silentNotificationEventHandler = { name, payload in
            eventName = name
            eventPayload = payload
        }

        fakeEMSPush.silentMessageEventHandler("testName", ["test": "payload"])

        XCTAssertEqual(eventName, "testName")
        XCTAssertEqual(eventPayload as! [String: String], ["test": "payload"])
    }

    func testSilentNotificationEventStream() {
        var testName = ""
        var testPayload: [String: String] = [:]

        let cancellable = self.pushInternal.silentNotificationEventStream.sink { error in
            print(error)
        } receiveValue: { event in
            testName = event.name
            testPayload = event.payload as! [String: String]
        }

        fakeEMSPush.silentMessageEventHandler("testName", ["test": "payload"])

        XCTAssertEqual("testName", testName)
        XCTAssertEqual("payload", testPayload["test"])
        cancellable.cancel()
    }

    func testNotificationEventHandler() {
        var eventName = ""
        var eventPayload: [String: Any?]? = [:]

        self.pushInternal.notificationEventHandler = { name, payload in
            eventName = name
            eventPayload = payload
        }

        fakeEMSPush.notificationEventHandler("testName", ["silent": "notificattionEvent"])

        XCTAssertEqual(eventName, "testName")
        XCTAssertEqual(eventPayload as! [String: String], ["silent": "notificattionEvent"])
    }

    func testNotificationEventStream() {
        var testName = ""
        var testPayload: [String: String] = [:]

        let cancellable = self.pushInternal.notificationEventStream.sink { error in
            print(error)
        } receiveValue: { event in
            testName = event.name
            testPayload = event.payload as! [String: String]
        }

        fakeEMSPush.notificationEventHandler("testName", ["silent": "notificattionEvent"])

        XCTAssertEqual("testName", testName)
        XCTAssertEqual("notificattionEvent", testPayload["silent"])
        cancellable.cancel()
    }

    func testSilentNotificationInformationHandler() {
        var testCampignId = ""

        self.pushInternal.silentNotificationInformationHandler = { notificationInformation in
            testCampignId = notificationInformation.campaignId
        }

        fakeEMSPush.silentMessageInformationBlock(EMSNotificationInformation(campaignId: "testCampignId"))

        XCTAssertEqual(testCampignId, "testCampignId")
    }

    func testSilentNotificationInformationStream() {
        var testCampignId = ""


        let cancellable = self.pushInternal.silentNotificationInformationStream.sink { error in
            print(error)
        } receiveValue: { notificationInformation in
            testCampignId = notificationInformation.campaignId
        }

        fakeEMSPush.silentMessageInformationBlock(EMSNotificationInformation(campaignId: "testCampignId"))

        XCTAssertEqual("testCampignId", testCampignId)
        cancellable.cancel()
    }

    func testNotificationInformationHandler() {
        var campignId = ""

        self.pushInternal.notificationInformationHandler = { notificationInformation in
            campignId = notificationInformation.campaignId
        }

        fakeEMSPush.notificationInformationBlock(EMSNotificationInformation(campaignId: "testCampignId"))

        XCTAssertEqual(campignId, "testCampignId")
    }

    func testNotificationInformationStream() {
        var testCampignId = ""


        let cancellable = self.pushInternal.notificationInformationStream.sink { error in
            print(error)
        } receiveValue: { notificationInformation in
            testCampignId = notificationInformation.campaignId
        }

        fakeEMSPush.notificationInformationBlock(EMSNotificationInformation(campaignId: "testCampignId"))

        XCTAssertEqual("testCampignId", testCampignId)
        cancellable.cancel()
    }

    func testDelegateSetter() {
        let testDelegate = FakeNotificationCenterDelegate()

        self.pushInternal.delegate = testDelegate

        XCTAssertNotNil(self.pushInternal.emsPush.delegate)
        XCTAssertTrue(testDelegate === self.pushInternal.emsPush.delegate)
    }
}
