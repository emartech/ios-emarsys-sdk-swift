//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
import ios_emarsys_sdk_swift


@objc public class FakeEMSPredict : NSObject, EMSPredictProtocol, EMSPredictInternalProtocol {
    
    var error: NSError? = nil
    var callHandler: CallHandler!
    var testProduct: EMSProductProtocol = FakeEMSProduct()
    
    public func setContactWithContactFieldId(_ contactFieldId: NSNumber!, contactFieldValue: String!) {
        self.callHandler(contactFieldId, contactFieldValue)
    }
    
    public func clearContact() {
        self.callHandler()
    }
    
    public func trackCart(items: [EMSCartItemProtocol]) {
        self.callHandler(items)
    }
    
    public func trackPurchase(orderId: String, items: [EMSCartItemProtocol]) {
        self.callHandler(orderId, items)
    }
    
    public func trackCategory(categoryPath: String) {
        self.callHandler(categoryPath)
    }
    
    public func trackItem(itemId: String) {
        self.callHandler(itemId)
    }
    
    public func trackSearch(searchTerm: String) {
        self.callHandler(searchTerm)
    }
    
    public func trackTag(tag: String, attributes: [String : String]? = nil) {
        self.callHandler(tag, attributes)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, limit: NSNumber?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, limit, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, filters: [EMSRecommendationFilterProtocol]?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic,filters,productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, filters: [EMSRecommendationFilterProtocol]?, limit: NSNumber?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, filters, limit, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, availabilityZone, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, limit: NSNumber?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, limit, availabilityZone, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, filters: [EMSRecommendationFilterProtocol]?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, filters, availabilityZone, productsBlock)
    }
    
    public func recommendProducts(logic: EMSLogicProtocol, filters: [EMSRecommendationFilterProtocol]?, limit: NSNumber?, availabilityZone: String?, productsBlock: @escaping EMSProductsBlock) {
        productsBlock([testProduct], error)
        self.callHandler(logic, filters, limit, availabilityZone, productsBlock)
    }
    
    public func trackRecommendationClick(product: EMSProductProtocol) {
        self.callHandler(product)
    }
}
