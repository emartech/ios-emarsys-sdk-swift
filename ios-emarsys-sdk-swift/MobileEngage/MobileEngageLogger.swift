//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class MobileEngageLogger: MobileEngageApi {
    
    let emsLoggingMobileEngage: EMSMobileEngageProtocol
    
    init(emsLoggingMobileEngage: EMSMobileEngageProtocol) {
        self.emsLoggingMobileEngage = emsLoggingMobileEngage
    }
    
    func setAuthenticatedContact(contactFieldId: NSNumber?, openIdToken: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingMobileEngage.setAuthenticatedContactWithContactFieldId(contactFieldId, openIdToken: openIdToken) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingMobileEngage.setContactWithContactFieldId(contactFieldId, contactFieldValue: contactFieldValue) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func clearContact() async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingMobileEngage.clearContact { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }

    }
    
    func trackCustomEvent(eventName: String, eventAttributes: [String : String]?) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingMobileEngage.trackCustomEvent(withName: eventName, eventAttributes: eventAttributes){ error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
