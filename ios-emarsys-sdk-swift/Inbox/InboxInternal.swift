//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class InboxInternal: InboxApi {
    
    let emsInbox: EMSMessageInboxProtocol
    
    init(emsInbox: EMSMessageInboxProtocol) {
        self.emsInbox = emsInbox
    }
    
    func fetchMessages() async throws -> [InboxMessage] {
        try await withUnsafeThrowingContinuation { continuation in
            emsInbox.fetchMessages { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let messages = result?.messages as? [InboxMessage] {
                    continuation.resume(returning: messages)
                }
            }
        }
    }
    
    func addTag(_ tag: String, _ messageId: String) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsInbox.addTag(tag: tag, messageId: messageId) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func removeTag(_ tag: String, _ messageId: String) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            emsInbox.removeTag(tag: tag, messageId: messageId) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
