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
        var testToken: Data? = nil
        var completionBlock : EMSCompletionBlock? = nil
        
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
        var testToken : Data? = nil
        var completionBlock : EMSCompletionBlock? = nil
        
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
        var completionBlock : EMSCompletionBlock? = nil
        
        fakeEMSPush.callHandler =  { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }
        
        try await self.pushInternal.clearPushToken()
        
        XCTAssertTrue(isCalled)
        XCTAssertNotNil(completionBlock)
    }
    
    func testClearPushToken_withError() async throws {
        var isCalled: Bool = false
        var completionBlock : EMSCompletionBlock? = nil
        
        fakeEMSPush.callHandler =  { (_ param: Any?...) in
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
        var expectedInfo :  [String: Any]? = nil
        var isCalled: Bool = false
        var completionBlock : EMSCompletionBlock? = nil
        
        fakeEMSPush.callHandler =  { (_ param: Any?...) in
            isCalled = true
            expectedInfo = (param[0] as!  [String: Any])
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
        var completionBlock : EMSCompletionBlock? = nil
        var expectedInfo :  [String: Any]? = nil
        
        fakeEMSPush.callHandler =  { (_ param: Any?...) in
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
        var expectedInfo :  [String: Any]? = nil
        
        fakeEMSPush.callHandler =  { (_ param: Any?...) in
            isCalled = true
            expectedInfo = (param[0] as! [String: Any])
        }
        
        await self.pushInternal.handleMessage(userInfo)
        
        XCTAssertTrue(isCalled)
        XCTAssertEqual(expectedInfo?["name"] as! String, "TestName")
    }
}
