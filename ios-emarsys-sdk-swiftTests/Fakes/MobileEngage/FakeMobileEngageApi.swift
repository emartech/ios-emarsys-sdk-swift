//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import ios_emarsys_sdk_swift

class FakeMobileEngageApi: Fakable, MobileEngageApi {
    
    func setAuthenticatedContact(contactFieldId: NSNumber?, openIdToken: String?) async throws {
        self.callHandler?(contactFieldId, openIdToken)
    }
    
    func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws {
        self.callHandler?(contactFieldId, contactFieldValue)
    }
    
    func clearContact() async throws {
        self.callHandler?()
    }
    
    func trackCustomEvent(eventName: String, eventAttributes: [String : String]?) async throws {
        self.callHandler?(eventName, eventAttributes)
    }
}
