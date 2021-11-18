//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class DeepLinkInternalTests: XCTestCase {
    
    var deepLinkInternal: DeepLinkInternal!
    var fakeEMSDeepLink: FakeEMSDeepLink!
    var testUserActivity: NSUserActivity!
    
    override func setUp() {
        super.setUp()
        fakeEMSDeepLink = FakeEMSDeepLink()
        deepLinkInternal = DeepLinkInternal(emsDeepLink: fakeEMSDeepLink)
        testUserActivity = NSUserActivity(activityType: "testUserActivity")
    }
    
    func testTrackDeepLink() async throws {
        var userActivity: NSUserActivity? = nil
        var completionBlock: EMSCompletionBlock? = nil
        
        fakeEMSDeepLink.callHandler =  { (_ param: Any?...) in
            userActivity = (param[0] as! NSUserActivity)
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        try await deepLinkInternal.trackDeepLink(userActivity: testUserActivity)
        
        XCTAssertEqual(userActivity, testUserActivity)
        XCTAssertNotNil(completionBlock)
    }
    
    func testTrackDeepLink_withError() async throws {
        
        fakeEMSDeepLink.callHandler =  { (_ param: Any?...) in  }
        
        fakeEMSDeepLink.error = NSError(code: 42, localizedDescription: "testErrorTrackDeepLink")
        
        do {
            _ = try await deepLinkInternal.trackDeepLink(userActivity: testUserActivity)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorTrackDeepLink")
        }
    }
}

