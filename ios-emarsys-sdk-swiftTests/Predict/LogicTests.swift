//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift
@testable import EmarsysSDKExposed

class LogicTests: XCTestCase {

    func testConstructor_variants_mustBeEmptyList_withoutVariantsParam() {
        let logic = Logic(logicName: LogicType.search.rawValue)
        XCTAssertEqual(logic.logicVariants, [])
    }

    func testConstructor_variants_mustBeEmptyList_withoutVariantsParam_data_mustBeEmptyMap_withoutDataParam() {
        let logic = Logic(logicName: LogicType.search.rawValue)

        XCTAssertEqual(logic.logicVariants, [])
        XCTAssertEqual(logic.logicData, [:])
    }

    func testSearch_shouldFillFields() {
        let result = Logic.search()

        XCTAssertEqual(result.logicName, "SEARCH")
        XCTAssertEqual(result.logicData, [:])
    }

    func testSearch_shouldFillFields_ifDataIsProvided() {
        let expectedData = ["q": "searchTerm"]
        let result = Logic.search(searchTerm: "searchTerm")

        XCTAssertEqual(result.logicName, "SEARCH")
        XCTAssertEqual(result.logicData, expectedData)

    }

    func testCart_shouldFillFields() {
        let result = Logic.cart()

        XCTAssertEqual(result.logicName, "CART")
        XCTAssertEqual(result.logicData, [:])
    }

    func testCart_shouldFillFields_ifDataIsProvided() {
        let data = [
            "cv": "1",
            "ca": "i:itemId1,p:200.0,q:100.0|i:itemId2,p:201.0,q:101.0"
        ]

        let cartItems = [
            PredictCartItem(itemId: "itemId1", price: 200.0, quantity: 100.0),
            PredictCartItem(itemId: "itemId2", price: 201.0, quantity: 101.0)]

        let result = Logic.cart(cartItems: cartItems)

        XCTAssertEqual(result.logicName, "CART")
        XCTAssertEqual(result.logicData, data)
    }

    func testRelated_shouldFillFields() {
        let result = Logic.related()

        XCTAssertEqual(result.logicName, "RELATED")
        XCTAssertEqual(result.logicData, [:])
    }


    func testRelated_shouldFillFields_ifDataIsProvided() {
        let data = ["v": "i:itemId"]

        let result = Logic.related(itemId: "itemId")

        XCTAssertEqual(result.logicName, "RELATED")
        XCTAssertEqual(result.logicData, data)
    }

    func testCategory_shouldFillFields() {
        let result = Logic.category()

        XCTAssertEqual(result.logicName, "CATEGORY")
        XCTAssertEqual(result.logicData, [:])
    }

    func testCategory_shouldFillFields_ifDataIsProvided() {
        let data = ["vc": "testCategoryPath"]

        let result = Logic.category(categoryPath: "testCategoryPath")

        XCTAssertEqual(result.logicName, "CATEGORY")
        XCTAssertEqual(result.logicData, data)
    }

    func testAlsoBought_shouldFillFields() {
        let result = Logic.alsoBought()

        XCTAssertEqual(result.logicName, "ALSO_BOUGHT")
        XCTAssertEqual(result.logicData, [:])
    }

    func testAlsoBought_shouldFillFields_ifDataIsProvided() {
        let data = ["v": "i:itemId"]

        let result = Logic.alsoBought(itemId: "itemId")

        XCTAssertEqual(result.logicName, "ALSO_BOUGHT")
        XCTAssertEqual(result.logicData, data)
    }

    func testPopular_shouldFillFields() {
        let result = Logic.popular()

        XCTAssertEqual(result.logicName, "POPULAR")
        XCTAssertEqual(result.logicData, [:])
    }

    func testPopular_shouldFillFields_ifDataIsProvided() {
        let data = ["vc": "testCategoryPath"]

        let result = Logic.popular(categoryPath: "testCategoryPath")

        XCTAssertEqual(result.logicName, "POPULAR")
        XCTAssertEqual(result.logicData, data)
    }

    func testPersonal_shouldFillFields() {
        let result = Logic.personal()

        XCTAssertEqual(result.logicData, [:])
        XCTAssertEqual(result.logicName, "PERSONAL")
    }

    func testPersonal_shouldFillFields_withVariants() {
        let expectedVariants = [
            "1",
            "2",
            "3"
        ]
        let result = Logic.personal(variants: expectedVariants)

        XCTAssertEqual(result.logicData, [:])
        XCTAssertEqual(result.logicVariants, expectedVariants)
        XCTAssertEqual(result.logicName, "PERSONAL")
    }

    func testHome_shouldFillFields() {
        let result = Logic.home()

        XCTAssertEqual(result.logicData, [:])
        XCTAssertEqual(result.logicName, "HOME")
    }

    func testHome_shouldFillFields_withVariants() {
        let expectedVariants = [
            "1",
            "2",
            "3"
        ]
        let result = Logic.home(variants: expectedVariants)

        XCTAssertEqual(result.logicData, [:])
        XCTAssertEqual(result.logicVariants, expectedVariants)
        XCTAssertEqual(result.logicName, "HOME")
    }
}
