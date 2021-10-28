//
// Created by Emarsys on 2021. 10. 28..
//

import Foundation

@objc public protocol InboxMessage {

    var id: String { get }
    var campaignId: String { get }
    var collapseId: String? { get }
    var title: String { get }
    var body: String { get }
    var imageUrl: String? { get }
    var receivedAt: NSNumber { get }
    var updatedAt: NSNumber? { get }
    var expiresAt: NSNumber? { get }
    var tags: [String]? { get }
    var properties: [String:String]? { get }
    var actions: [Action] { get }

}