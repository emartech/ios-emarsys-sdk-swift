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
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        _ = try await self.inboxInternal.fetchMessages()

        XCTAssertTrue(isCalled)
    }

    func testFetchMessages_withError() async throws {
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorFetch")

        do {
            _ = try await self.inboxInternal.fetchMessages()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorFetch")
        }

        XCTAssertTrue(isCalled)
    }

    func testAddTag() async throws {
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        fakeEMSInbox.error = nil

        try await self.inboxInternal.addTag("testTag", "testId")

        XCTAssertTrue(isCalled)
    }

    func testAddTag_withError() async throws {
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorAdd")

        do {
            try await self.inboxInternal.addTag("testTag", "testId")
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorAdd")
        }

        XCTAssertTrue(isCalled)
    }

    func testRemoveTag() async throws {
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        try await self.inboxInternal.removeTag("testTag", "testId")

        XCTAssertTrue(isCalled)
    }

    func testRemoveTag_withError() async throws {
        var isCalled: Bool = false

        fakeEMSInbox.callHandler = {
            isCalled = true
        }

        fakeEMSInbox.error = NSError(code: 42, localizedDescription: "testErrorRemove")

        do {
            try await self.inboxInternal.removeTag("testTag", "testId")
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorRemove")
        }

        XCTAssertTrue(isCalled)
    }
}
