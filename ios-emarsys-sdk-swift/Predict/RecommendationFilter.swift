//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

public class RecommendationFilter: NSObject {

    let type: String
    let field: String
    let comparison: String
    let expectations: [String?]

    internal init(type: String, field: String, comparison: ComparisonType, expectations: [String?]) {
        self.type = type
        self.field = field
        self.comparison = comparison.rawValue
        self.expectations = expectations
    }

    internal init(type: String, field: String, comparison: ComparisonType, expectation: String?) {
        self.type = type
        self.field = field
        self.comparison = comparison.rawValue
        expectations = [expectation]
    }

    static func exclude(_ field: String) -> Exclude {
        Exclude.exclude(field)
    }

    static func include(_ field: String) -> Include {
        Include.include(field)
    }

    public override var hash: Int {
        var result = type.hashValue
        result = result &* 31 &+ field.hashValue
        result = result &* 31 &+ comparison.hashValue
        result = result &* 31 &+ expectations.hashValue
        return result
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RecommendationFilter else {
            return false
        }
        if self === object {
            return true
        }
        return self.type == object.type
                && self.field == object.field
                && self.comparison == object.comparison
                && self.expectations == object.expectations
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
