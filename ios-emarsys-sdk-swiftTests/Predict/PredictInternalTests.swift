//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class PredictInternalTests: XCTestCase {
    
    var fakeEMSPredict: FakeEMSPredict!
    var predictInternal: PredictInternal!
    var testCartItems: [PredictCartItem]!
    var testOrderId: String!
    var testCategory: String!
    var testItemView: String!
    var testSearch: String!
    var testTag: String!
    var testAttributes: [String: String]!
    var testProduct: Product!
    var testEmsProduct: FakeEMSProduct!
    var testLogic: Logic!
    var testFilters: [RecommendationFilter]!
    var testLimit: NSNumber!
    var testZone: String!
    
    override func setUp() {
        super.setUp()
        fakeEMSPredict = FakeEMSPredict()
        predictInternal = PredictInternal(emsPredict: fakeEMSPredict)
        testCartItems = [PredictCartItem(itemId: "testId", price: 450.2, quantity: 2.5)]
        testOrderId = "testOrderId"
        testCategory = "testCategory"
        testItemView = "testItemView"
        testSearch = "testSearch"
        testTag = "testTag"
        testAttributes = ["name" : "TestName"]
        testEmsProduct = FakeEMSProduct()
        testProduct = Product(testEmsProduct)
        testLogic = Logic(logicName: "testLogic")
        testFilters = [RecommendationFilter.include("testField").hasValue("has")]
        testLimit = 5
        testZone = "testZone"
    }
    
    func testTrackCart() async {
        var cartItems: [PredictCartItem]? = nil
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            cartItems = (param[0] as! [PredictCartItem])
        }
        
        await self.predictInternal.trackCart(testCartItems)
        
        XCTAssertEqual(cartItems, testCartItems)
    }
    
    func testTrackPurchase() async {
        var cartItems: [PredictCartItem]? = nil
        var orderId: String = ""
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            orderId = param[0] as! String
            cartItems = (param[1] as! [PredictCartItem])
        }
        
        await self.predictInternal.trackPurchase(testOrderId, testCartItems)
        
        XCTAssertEqual(cartItems, testCartItems)
        XCTAssertEqual(orderId, testOrderId)
    }
    
    func testTrackCategory() async {
        var category: String = ""
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            category = (param[0] as! String)
        }
        
        await self.predictInternal.trackCategory(testCategory)
        
        XCTAssertEqual(category, testCategory)
    }
    
    func testTrackItemView() async {
        var itemsView: String = ""
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            itemsView = (param[0] as! String)
        }
        
        await self.predictInternal.trackItemView(testItemView)
        
        XCTAssertEqual(itemsView, testItemView)
    }
    
    func testTrackSearch() async {
        var search: String = ""
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            search = (param[0] as! String)
        }
        
        await self.predictInternal.trackSearch(testSearch)
        
        XCTAssertEqual(search, testSearch)
    }
    
    func testTrackTag() async {
        var tag: String = ""
        var attributes: [String : String]? = nil
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            tag = (param[0] as! String)
            attributes = (param[1] as! [String : String])
        }
        
        await self.predictInternal.trackTag(testTag, testAttributes)
        
        XCTAssertEqual(tag, testTag)
        XCTAssertEqual(attributes, testAttributes)
    }

    func testRecommendationClick() async {
        var product: Product? = nil
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            product = (param[0] as! Product)
        }
        
        await self.predictInternal.trackRecommendationClick(testProduct)
        
        XCTAssertEqual(product, testProduct)
    }
    
    func testRecommendProducts() async throws {
        var logic: Logic? = nil
        var filters: [RecommendationFilter]? = nil
        var limit: NSNumber? = nil
        var zone: String? = nil
        var block: EMSProductsBlock? = nil
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            logic = (param[0] as! Logic)
            filters = (param[1] as! [RecommendationFilter])
            limit = (param[2] as! NSNumber)
            zone = (param[3] as! String)
            block = (param[4] as! EMSProductsBlock)
        }
        
        let result = try await self.predictInternal.recommendProducts(logic: testLogic, filters: testFilters, limit: testLimit, availabilityZone: testZone)
        XCTAssertEqual(logic, testLogic)
        XCTAssertEqual(filters, testFilters)
        XCTAssertEqual(limit, testLimit)
        XCTAssertEqual(zone, testZone)
        XCTAssertNotNil(block)
        XCTAssertEqual(result[0].productId, "productId")
        XCTAssertEqual(result[0].title, "title")
        XCTAssertEqual(result[0].linkUrl, URL(string: "https://emarsys.com")!)
        XCTAssertEqual(result[0].customFields["1"] as! String, "2")
        XCTAssertEqual(result[0].feature, "feature")
        XCTAssertEqual(result[0].cohort, "cohort")
        XCTAssertEqual(result[0].imageUrl, URL(string: "https://emarsys.com")!)
        XCTAssertEqual(result[0].zoomImageUrl, URL(string: "https://emarsys.com")!)
        XCTAssertEqual(result[0].categoryPath, "categoryPath")
        XCTAssertEqual(result[0].available, 2)
        XCTAssertEqual(result[0].productDescription, "description")
        XCTAssertEqual(result[0].price, 12)
        XCTAssertEqual(result[0].msrp, 5)
        XCTAssertEqual(result[0].album, "album")
        XCTAssertEqual(result[0].actor, "actor")
        XCTAssertEqual(result[0].artist, "artist")
        XCTAssertEqual(result[0].author, "author")
        XCTAssertEqual(result[0].brand, "brand")
        XCTAssertEqual(result[0].year, 2000)
    }
    
    func testRecommendProducts_withError() async throws {
        var isCalled: Bool = false
        
        fakeEMSPredict.callHandler = { (_ param: Any?...) in
            isCalled = true
        }
        
        fakeEMSPredict.error = NSError(code: 42, localizedDescription: "testErrorRecommendProducts")
        
        do {
            _ = try await self.predictInternal.recommendProducts(logic: testLogic, filters: testFilters, limit: testLimit, availabilityZone: testZone)
        } catch {
            XCTAssertEqual(error.localizedDescription, "testErrorRecommendProducts")
        }
        
        XCTAssertTrue(isCalled)
    }
}
