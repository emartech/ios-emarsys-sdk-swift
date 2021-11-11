//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class PredictLogger: PredictApi {

    let emsLoggingPredict: EMSPredictProtocol

    init(emsLoggingPredict: EMSPredictProtocol) {
        self.emsLoggingPredict = emsLoggingPredict
    }

    func trackCart(_ items: [CartItem]) async {
        emsLoggingPredict.trackCart(items: items)
    }

    func trackPurchase(_ orderId: String, _ items: [CartItem]) async {
        emsLoggingPredict.trackPurchase(orderId: orderId, items: items)
    }

    func trackCategory(_ categoryPath: String) async {
        emsLoggingPredict.trackCategory(categoryPath: categoryPath)
    }

    func trackItemView(_ itemId: String) async {
        emsLoggingPredict.trackItem(itemId: itemId)
    }

    func trackSearch(_ searchTerm: String) async {
        emsLoggingPredict.trackSearch(searchTerm: searchTerm)
    }

    func trackTag(_ tag: String, _ attributes: [String: String]?) async {
        emsLoggingPredict.trackTag(tag: tag, attributes: attributes)
    }

    func trackRecommendationClick(_ product: Product) async {
        emsLoggingPredict.trackRecommendationClick(product: product)
    }

    func recommendProducts(logic: Logic, filters: [RecommendationFilter]?, limit: NSNumber?, availabilityZone: String?) async throws -> [Product] {
        return try await withUnsafeThrowingContinuation { continuation in
            emsLoggingPredict.recommendProducts(logic: logic, filters: filters, limit: limit, availabilityZone: availabilityZone) { products, error  in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let products = products {
                    continuation.resume(returning: products.map{ Product($0) })
                }
            }
        }
    }
}
