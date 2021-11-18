//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class MobileEngageInternalTests: XCTestCase {
    
    var fakeEMSMobileEngage: FakeEMSMobileEngage!
    var mobileEngageInternal: MobileEngageInternal!
    var testContactFieldId: NSNumber!
    var testOpenIdToken: String!
    var testContactFieldValue: String!
    var testEventName: String!
    var testAttributes: [String : String]!
    
    override func setUp() {
        super.setUp()
        fakeEMSMobileEngage = FakeEMSMobileEngage()
        mobileEngageInternal = MobileEngageInternal(emsMobileEngage: fakeEMSMobileEngage)
        testContactFieldId = 2575
        testOpenIdToken = "testOpenIdToken"
        testContactFieldValue = "testContactFieldValue"
        testEventName = "testEventName"
        testAttributes = ["attribute" : "test"]
    }
    
    func testSetAuthenticatedContact() async throws {
        var contactfieldId: NSNumber!
        var openIdToken = ""
        var completionBlock: EMSCompletionBlock? = nil
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in
            contactfieldId = (param[0] as! NSNumber)
            openIdToken = param[1] as! String
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        try await mobileEngageInternal.setAuthenticatedContact(contactFieldId: testContactFieldId, openIdToken: testOpenIdToken)
        
        XCTAssertEqual(contactfieldId, testContactFieldId)
        XCTAssertEqual(openIdToken, testOpenIdToken)
        XCTAssertNotNil(completionBlock)
    }
    
    func testSetAuthenticatedContact_withError() async throws {
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in  }
        
        fakeEMSMobileEngage.error = NSError(code: 42, localizedDescription: "testErrorSetAuthenticatedContact")
        
        do {
            _ = try await self.mobileEngageInternal.setAuthenticatedContact(contactFieldId: testContactFieldId, openIdToken: testOpenIdToken)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorSetAuthenticatedContact")
        }
    }
    
    func testSetContact() async throws {
        var contactfieldId: NSNumber!
        var contactFieldValue: String? = nil
        var completionBlock: EMSCompletionBlock? = nil
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in
            contactfieldId = (param[0] as! NSNumber)
            contactFieldValue = (param[1] as! String)
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        try await mobileEngageInternal.setContact(contactFieldId: testContactFieldId, contactFieldValue: testContactFieldValue)
        
        XCTAssertEqual(contactfieldId, testContactFieldId)
        XCTAssertEqual(contactFieldValue, testContactFieldValue)
        XCTAssertNotNil(completionBlock)
    }
    
    func testSetContact_withError() async throws {
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in  }
        
        fakeEMSMobileEngage.error = NSError(code: 42, localizedDescription: "testErrorSetContact")
        
        do {
            _ = try await self.mobileEngageInternal.setContact(contactFieldId: testContactFieldId, contactFieldValue: testContactFieldValue)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorSetContact")
        }
    }
    
    func testClearContact() async throws {
        var isCalled: Bool = false
        var completionBlock: EMSCompletionBlock? = nil
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in
            isCalled = true
            completionBlock = (param[0] as! EMSCompletionBlock)
        }
        
        try await mobileEngageInternal.clearContact()
        
        XCTAssertTrue(isCalled)
        XCTAssertNotNil(completionBlock)
    }
    
    func testClearContact_withError() async throws {
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in  }
        
        fakeEMSMobileEngage.error = NSError(code: 42, localizedDescription: "testErrorClearContact")
        
        do {
            _ = try await self.mobileEngageInternal.clearContact()
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorClearContact")
        }
    }
    
    func testTrackCustomEvent() async throws {
        var isCalled: Bool = false
        var eventName: String? = nil
        var attributes: [String : String]? = nil
        var completionBlock: EMSCompletionBlock? = nil
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in
            isCalled = true
            eventName = (param[0] as! String)
            attributes = (param[1] as! [String : String])
            completionBlock = (param[2] as! EMSCompletionBlock)
        }
        
        try await mobileEngageInternal.trackCustomEvent(eventName: testEventName, eventAttributes: testAttributes)

        XCTAssertTrue(isCalled)
        XCTAssertEqual(eventName, testEventName)
        XCTAssertEqual(attributes, testAttributes)
        XCTAssertNotNil(completionBlock)
    }
    
    func testTrackCustomEvent_withError() async throws {
        
        fakeEMSMobileEngage.callHandler =  { (_ param: Any?...) in  }
        
        fakeEMSMobileEngage.error = NSError(code: 42, localizedDescription: "testErrorTrackCustomEvent")
        
        do {
            _ = try await mobileEngageInternal.trackCustomEvent(eventName: testEventName, eventAttributes: testAttributes)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorTrackCustomEvent")
        }
    }

}
