//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

@objc public class Product: NSObject, EMSProductProtocol {

    public var productId: String

    public var title: String

    public var linkUrl: URL

    public var customFields: [String : Any]

    public var feature: String

    public var cohort: String

    public var imageUrl: URL?

    public var zoomImageUrl: URL?

    public var categoryPath: String?

    public var available: NSNumber?

    public var productDescription: String?

    public var price: NSNumber?

    public var msrp: NSNumber?

    public var album: String?

    public var actor: String?

    public var artist: String?

    public var author: String?

    public var brand: String?

    public var year: NSNumber?

    internal init(_ product: EMSProductProtocol) {
        productId = product.productId
        title = product.title
        linkUrl = product.linkUrl
        customFields = product.customFields
        feature = product.feature
        cohort = product.cohort
        imageUrl = product.imageUrl
        zoomImageUrl = product.zoomImageUrl
        categoryPath = product.categoryPath
        available = product.available
        productDescription = product.productDescription
        price = product.price
        msrp = product.msrp
        album = product.album
        `actor` = product.actor
        artist = product.artist
        author = product.author
        brand = product.brand
        year = product.year
        super.init()
    }

}
