//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation


public protocol ExposedPredict {
    
    func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws
    
    func clearContact() async throws
}
