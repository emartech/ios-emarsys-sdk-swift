//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

public class RecommendationFilter: NSObject, EMSRecommendationFilterProtocol {

    let filterType: String
    let filterField: String
    let filterComparison: String
    let filterExpectations: [String]

    internal init(type: String, field: String, comparison: ComparisonType, expectations: [String]) {
        self.filterType = type
        self.filterField = field
        self.filterComparison = comparison.rawValue
        self.filterExpectations = expectations
    }

    internal init(type: String, field: String, comparison: ComparisonType, expectation: String) {
        self.filterType = type
        self.filterField = field
        self.filterComparison = comparison.rawValue
        filterExpectations = [expectation]
    }
    
    public func type() -> String! {
        self.filterType
    }
    
    public func field() -> String! {
        self.filterField
    }
    
    public func comparison() -> String! {
        self.filterComparison
    }
    
    public func expectations() -> [String]! {
        self.filterExpectations
    }

    static func exclude(_ field: String) -> Exclude {
        Exclude.exclude(field)
    }

    static func include(_ field: String) -> Include {
        Include.include(field)
    }

    public override var hash: Int {
        var result = filterType.hashValue
        result = result &* 31 &+ filterField.hashValue
        result = result &* 31 &+ filterComparison.hashValue
        result = result &* 31 &+ filterExpectations.hashValue
        return result
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RecommendationFilter else {
            return false
        }
        if self === object {
            return true
        }
        return self.filterType == object.filterType
                && self.filterField == object.filterField
                && self.filterComparison == object.filterComparison
                && self.filterExpectations == object.filterExpectations
    }

    class Exclude {
        private static let TYPE = "EXCLUDE"
        internal let field: String

        private init(_ field: String) {
            self.field = field
        }

        static func exclude(_ field: String) -> Exclude {
            Exclude(field)
        }

        func isValue(_ value: String) -> RecommendationFilter {
            RecommendationFilter(type: Exclude.TYPE, field: field, comparison: ComparisonType.is, expectation: value)
        }

        func inValues(_ values: [String]) -> RecommendationFilter {
            RecommendationFilter(type: Exclude.TYPE, field: field, comparison: ComparisonType.in, expectations: values)
        }

        func hasValue(_ value: String) -> RecommendationFilter {
            RecommendationFilter(type: Exclude.TYPE, field: field, comparison: ComparisonType.has, expectation: value)
        }

        func overlapsValues(_ values: [String]) -> RecommendationFilter {
            RecommendationFilter(type: Exclude.TYPE, field: field, comparison: ComparisonType.overlaps, expectations: values)
        }
    }

    class Include {
        private static let TYPE = "INCLUDE"
        internal let field: String

        private init(_ field: String) {
            self.field = field
        }

        static func include(_ field: String) -> Include {
            Include(field)
        }

        func isValue(_ value: String) -> RecommendationFilter {
            RecommendationFilter(type: Include.TYPE, field: field, comparison: ComparisonType.is, expectation: value)
        }

        func inValues(_ values: [String]) -> RecommendationFilter {
            RecommendationFilter(type: Include.TYPE, field: field, comparison: ComparisonType.in, expectations: values)
        }

        func hasValue(_ value: String) -> RecommendationFilter {
            RecommendationFilter(type: Include.TYPE, field: field, comparison: ComparisonType.has, expectation: value)
        }

        func overlapsValues(_ values: [String]) -> RecommendationFilter {
            RecommendationFilter(type: Include.TYPE, field: field, comparison: ComparisonType.overlaps, expectations: values)
        }
    }
}
