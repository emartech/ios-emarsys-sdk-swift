//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class InboxInternalTests: XCTestCase {
    var fakeEMSInbox: FakeEMSInbox!
    var inboxInternal: InboxInternal!
    
    override func setUp() {
        super.setUp()
        fakeEMSInbox = FakeEMSInbox()
        inboxInternal = InboxInternal(emsInbox: fakeEMSInbox)
    }
    
    func testFetchMessages() async throws {
        var fakeInboxresult : EMSInboxMessageResultBlock? = nil
        let expectedResult : [InboxMessage] = fakeEMSInbox.fakeResult.messages as! [InboxMessage]
        
        fakeEMSInbox.callHandler = { (_ param: Any?...) in
            fakeInboxresult = (param[0] as! EMSInboxMessageResultBlock)
        }
        
        let result = try await self.inboxInternal.fetchMessages()
        
        XCTAssertEqual(result, expectedResult)
        XCTAssertNotNil(fakeInboxresult)
    }
    
    func testFetchMessages_withError() async throws {
        var isCalled: Bool = false
        
        fakeEMSInbox.callHandler = { (_ param: Any?...) in isCalled = true }
        
        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorFetch")
        
        do {
            _ = try await self.inboxInternal.fetchMessages()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorFetch")
        }
        
        XCTAssertTrue(isCalled)
    }
    
    func testAddTag() async throws {
        var completionBlock : EMSCompletionBlock? = nil
        var testTagValue : String? = nil
        var testidValue : String? = nil
        
        fakeEMSInbox.callHandler = { (_ param: Any?...) in
            testTagValue = (param[0] as! String)
            testidValue = (param[1] as! String)
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        fakeEMSInbox.error = nil
        
        try await self.inboxInternal.addTag("testTag", "testId")
        
        XCTAssertNotNil(completionBlock)
        XCTAssertEqual(testTagValue, "testTag")
        XCTAssertEqual(testidValue, "testId")
    }
    
    func testAddTag_withError() async throws {
        var isCalled: Bool = false
        
        fakeEMSInbox.callHandler = { (_ param: Any?...) in isCalled = true }
        
        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorAdd")
        
        do {
            try await self.inboxInternal.addTag("testTag", "testId")
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorAdd")
        }
        
        XCTAssertTrue(isCalled)
    }
    
    func testRemoveTag() async throws {
        var completionBlock : EMSCompletionBlock? = nil
        var testTagValue : String? = nil
        var testidValue : String? = nil

        fakeEMSInbox.callHandler = { (_ param: Any?...) in
            testTagValue = (param[0] as! String)
            testidValue = (param[1] as! String)
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        try await self.inboxInternal.removeTag("testTag", "testId")
        
        XCTAssertNotNil(completionBlock)
        XCTAssertEqual(testTagValue, "testTag")
        XCTAssertEqual(testidValue, "testId")
    }
    
    func testRemoveTag_withError() async throws {
        var isCalled: Bool = false
        
        fakeEMSInbox.callHandler = { (_ param: Any?...) in isCalled = true }
        
        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorRemove")
        
        do {
            try await self.inboxInternal.removeTag("testTag", "testId")
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorRemove")
        }
        
        XCTAssertTrue(isCalled)
    }
}
