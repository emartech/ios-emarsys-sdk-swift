//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

@objc public class FakeEMSProduct: NSObject, EMSProductProtocol {
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
    
    public override init() {
        self.productId = "productId"
        self.title = "title"
        self.linkUrl = URL(string: "https://emarsys.com")!
        self.customFields = ["1" : "2"]
        self.feature = "feature"
        self.cohort = "cohort"
        super.init()
        
        self.imageUrl = URL(string: "https://emarsys.com")!
        self.zoomImageUrl = URL(string: "https://emarsys.com")!
        self.categoryPath = "categoryPath"
        self.available = 2
        self.productDescription = "description"
        self.price = 12
        self.msrp = 5
        self.album = "album"
        self.actor = "actor"
        self.artist = "artist"
        self.author = "author"
        self.brand = "brand"
        self.year = 2000
    }
}
