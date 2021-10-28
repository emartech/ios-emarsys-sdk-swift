//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation

@objc public protocol PredictApi {

    func trackCart(_  items: [CartItem]) async

    func trackPurchase(_ orderId: String, _ items: [CartItem]) async

    func trackCategory(_ categoryPath: String) async

    func trackItemView(_ itemId: String) async

    func trackSearch(_ searchTerm: String) async

    func trackTag(_ tag: String, _ attributes: [String: String]?) async

    func trackRecommendationClick(_ product: Product) async

    func recommendProducts(logic: Logic, filters: [RecommendationFilter]?, limit: NSNumber?, availabilityZone: String?) async throws -> [Product]

}

