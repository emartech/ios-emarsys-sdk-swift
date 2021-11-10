//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation

@objc public protocol InboxApi {
    
    func fetchMessages() async throws -> [InboxMessage]

    func addTag(_ tag: String, _ messageId: String) async throws

    func removeTag(_ tag: String, _ messageId: String) async throws
}
