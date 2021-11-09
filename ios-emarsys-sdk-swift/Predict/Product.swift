//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

@objc public protocol Product {
    var productId: String { get }
    var title: String { get }
    var linkUrl: String { get }
    var feature: String { get }
    var cohort: String { get }
    var customFields: [String: String] { get }
    var imageUrl: URL? { get }
    var zoomImageUrl: URL?  { get }
    var categoryPath: String? { get }
    var available: NSNumber? { get }
    var productDescription: String? { get }
    var price: NSNumber?  { get }
    var msrp: NSNumber?  { get }
    var album: String?  { get }
    var actor: String?  { get }
    var artist: String?  { get }
    var author: String?  { get }
    var brand: String?  { get }
    var year: NSNumber?  { get }
}