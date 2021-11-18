//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class PredictInternal: PredictApi {

    let emsPredict: EMSPredictProtocol

    init(emsPredict: EMSPredictProtocol) {
        self.emsPredict = emsPredict
    }

    func trackCart(_ items: [CartItem]) async {
        emsPredict.trackCart(items: items)
    }

    func trackPurchase(_ orderId: String, _ items: [CartItem]) async {
        emsPredict.trackPurchase(orderId: orderId, items: items)
    }

    func trackCategory(_ categoryPath: String) async {
        emsPredict.trackCategory(categoryPath: categoryPath)
    }

    func trackItemView(_ itemId: String) async {
        emsPredict.trackItem(itemId: itemId)
    }

    func trackSearch(_ searchTerm: String) async {
        emsPredict.trackSearch(searchTerm: searchTerm)
    }

    func trackTag(_ tag: String, _ attributes: [String: String]?) async {
        emsPredict.trackTag(tag: tag, attributes: attributes)
    }

    func trackRecommendationClick(_ product: Product) async {
        emsPredict.trackRecommendationClick(product: product)
    }

    func recommendProducts(logic: Logic, filters: [RecommendationFilter]?, limit: NSNumber?, availabilityZone: String?) async throws -> [Product] {
        return try await withUnsafeThrowingContinuation { continuation in
            emsPredict.recommendProducts(logic: logic, filters: filters, limit: limit, availabilityZone: availabilityZone) { products, error  in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let products = products {
                    continuation.resume(returning: products.map{ Product($0) })
                } else {
                    continuation.resume(returning: [])
                }
            }
        }
    }
}
