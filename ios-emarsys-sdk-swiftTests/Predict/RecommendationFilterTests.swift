//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import XCTest
@testable import ios_emarsys_sdk_swift

class RecommendationFilterTests: XCTestCase {

    private let EXCLUDE_TYPE = "EXCLUDE"
    private let INCLUDE_TYPE = "INCLUDE"
    private let FIELD = "field"
    private let SINGLE_EXPECTATION = "singleExpectation"
    private let MULTIPLE_EXPECTATIONS = ["expectation1", "expectation2"]

    var exclude: RecommendationFilter.Exclude!
    var include: RecommendationFilter.Include!

    override func setUpWithError() throws {
        exclude = RecommendationFilter.exclude(FIELD)
        include = RecommendationFilter.include(FIELD)
    }

    func testExclude_shouldReturn_withExcludeInstance() {
        XCTAssertTrue(RecommendationFilter.exclude(FIELD) is RecommendationFilter.Exclude)
    }

    func testExcludeConstructor_withField() {
        XCTAssertEqual(RecommendationFilter.exclude(FIELD).field, "field")
    }

    func testExclude_is_shouldReturn_RecommendationFilter() {
        XCTAssertTrue(exclude.isValue("singleExpectation") is RecommendationFilter)
    }

    func testExclude_is_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: EXCLUDE_TYPE, field: FIELD, comparison: ComparisonType.is, expectation: SINGLE_EXPECTATION)
        let result = exclude.isValue("singleExpectation")

        XCTAssertEqual(result, expected)
    }

    func testExclude_in_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: EXCLUDE_TYPE, field: FIELD, comparison: ComparisonType.in, expectations: MULTIPLE_EXPECTATIONS)
        let result = exclude.inValues(["expectation1", "expectation2"])

        XCTAssertEqual(result, expected)
    }

    func testExclude_has_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: EXCLUDE_TYPE, field: FIELD, comparison: ComparisonType.has, expectation: SINGLE_EXPECTATION)
        let result = exclude.hasValue("singleExpectation")

        XCTAssertEqual(result, expected)
    }

    func testExclude_overlaps_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: EXCLUDE_TYPE, field: FIELD, comparison: ComparisonType.overlaps, expectations: MULTIPLE_EXPECTATIONS)
        let result = exclude.overlapsValues(["expectation1", "expectation2"])

        XCTAssertEqual(result, expected)
    }

    func testInclude_shouldReturn_withIncludeInstance() {
        XCTAssertTrue(RecommendationFilter.include(FIELD) is RecommendationFilter.Include)
    }

    func testIncludeConstructor_withField() {
        XCTAssertEqual(RecommendationFilter.include(FIELD).field, "field")
    }

    func testInclude_is_shouldReturn_RecommendationFilter() {
        XCTAssertTrue(include.isValue("singleExpectation") is RecommendationFilter)
    }

    func testInclude_is_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: INCLUDE_TYPE, field: FIELD, comparison: ComparisonType.is, expectation: SINGLE_EXPECTATION)
        let result = include.isValue("singleExpectation")

        XCTAssertEqual(result, expected)
    }

    func testInclude_in_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: INCLUDE_TYPE, field: FIELD, comparison: ComparisonType.in, expectations: MULTIPLE_EXPECTATIONS)
        let result = include.inValues(["expectation1", "expectation2"])

        XCTAssertEqual(result, expected)
    }

    func testInclude_has_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: INCLUDE_TYPE, field: FIELD, comparison: ComparisonType.has, expectation: SINGLE_EXPECTATION)
        let result = include.hasValue("singleExpectation")

        XCTAssertEqual(result, expected)
    }

    func testInclude_overlaps_shouldReturn_RecommendationFilterFilledWithInputParameters() {
        let expected = RecommendationFilter(type: INCLUDE_TYPE, field: FIELD, comparison: ComparisonType.overlaps, expectations: MULTIPLE_EXPECTATIONS)
        let result = include.overlapsValues(["expectation1", "expectation2"])

        XCTAssertEqual(result, expected)
    }
}