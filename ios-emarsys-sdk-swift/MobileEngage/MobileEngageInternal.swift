//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class MobileEngageInternal: MobileEngageApi {
    
    let emsMobileEngage: EMSMobileEngageProtocol
    
    init(emsMobileEngage: EMSMobileEngageProtocol) {
        self.emsMobileEngage = emsMobileEngage
    }
    
    public func setAuthenticatedContact(contactFieldId: NSNumber?, openIdToken: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsMobileEngage.setAuthenticatedContactWithContactFieldId(contactFieldId, openIdToken: openIdToken) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    public func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsMobileEngage.setContactWithContactFieldId(contactFieldId, contactFieldValue: contactFieldValue) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    public func clearContact() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsMobileEngage.clearContact() { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    public func trackCustomEvent(eventName: String, eventAttributes: [String : String]?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsMobileEngage.trackCustomEvent(withName: eventName, eventAttributes: eventAttributes){ error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
