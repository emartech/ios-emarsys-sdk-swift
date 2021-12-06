//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import ios_emarsys_sdk_swift


class FakePredictApi: PredictApi, ExposedPredict, Fakable {
    
    func setContact(contactFieldId: NSNumber?, contactFieldValue: String?) async throws {
        self.callHandler?(contactFieldId, contactFieldValue)
    }
    
    func clearContact() async throws {
        self.callHandler?()
    }
    
    func trackCart(_ items: [CartItem]) async {
        self.callHandler?(items)
    }
    
    func trackPurchase(_ orderId: String, _ items: [CartItem]) async {
        self.callHandler?(orderId, items)
    }
    
    func trackCategory(_ categoryPath: String) async {
        self.callHandler?(categoryPath)
    }
    
    func trackItemView(_ itemId: String) async {
        self.callHandler?(itemId)
    }
    
    func trackSearch(_ searchTerm: String) async {
        self.callHandler?(searchTerm)
    }
    
    func trackTag(_ tag: String, _ attributes: [String : String]?) async {
        self.callHandler?(tag, attributes)
    }
    
    func trackRecommendationClick(_ product: Product) async {
        self.callHandler?(product)
    }
    
    func recommendProducts(logic: Logic, filters: [RecommendationFilter]?, limit: NSNumber?, availabilityZone: String?) async throws -> [Product] {
        self.callHandler?(logic, filters, limit, availabilityZone)
        return []
    }
}
