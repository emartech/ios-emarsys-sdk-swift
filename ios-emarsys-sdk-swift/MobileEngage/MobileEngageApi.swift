//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation

@objc public protocol MobileEngageApi {
    
    func setAuthenticatedContact(contactFieldId: NSNumber?, openIdToken: String?) async throws
    
    func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws
    
    func clearContact() async throws
    
    func trackCustomEvent(eventName: String, eventAttributes: [String : String]?) async throws
}
