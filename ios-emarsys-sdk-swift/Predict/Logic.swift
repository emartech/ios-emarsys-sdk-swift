//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

@objc public class Logic: NSObject {
    public var logicName: String

    public var data: [String: String]

    public var variants: [String]

    internal init(logicName: String, data: [String: String] = [:], variants: [String] = []) {
        self.logicName = logicName
        self.data = data
        self.variants = variants
    }

    static func search() -> Logic {
        Logic(logicName: LogicType.SEARCH.rawValue)
    }

    static func search(searchTerm: String) -> Logic {
        let data = [
            "q": searchTerm
        ]
        return Logic(logicName: LogicType.SEARCH.rawValue, data: data)
    }

    static func cart() -> Logic {
        Logic(logicName: LogicType.CART.rawValue)
    }

    static func cart(cartItems: [CartItem]) -> Logic {
        let data = [
            "cv": "1",
            "ca": cartItemsToQueryParam(cartItems)
        ]
        return Logic(logicName: LogicType.CART.rawValue, data: data)
    }

    static func related() -> Logic {
        Logic(logicName: LogicType.RELATED.rawValue)
    }

    static func related(itemId: String) -> Logic {
        let data = [
            "v": "i:\(itemId)"
        ]
        return Logic(logicName: LogicType.RELATED.rawValue, data: data)
    }

    static func category() -> Logic {
        Logic(logicName: LogicType.CATEGORY.rawValue)
    }

    static func category(categoryPath: String) -> Logic {
        let data = [
            "vc": categoryPath
        ]
        return Logic(logicName: LogicType.CATEGORY.rawValue, data: data)
    }

    static func alsoBought() -> Logic {
        Logic(logicName: LogicType.ALSO_BOUGHT.rawValue)
    }

    static func alsoBought(itemId: String) -> Logic {
        let data = [
            "v": "i:\(itemId)"
        ]
        return Logic(logicName: LogicType.ALSO_BOUGHT.rawValue, data: data)
    }

    static func popular() -> Logic {
        Logic(logicName: LogicType.POPULAR.rawValue)
    }

    static func popular(categoryPath: String) -> Logic {
        let data = [
            "vc": categoryPath
        ]
        return Logic(logicName: LogicType.POPULAR.rawValue, data: data)
    }

    static func personal() -> Logic {
        Logic(logicName: LogicType.PERSONAL.rawValue)
    }

    static func personal(variants: [String]) -> Logic {
        Logic(logicName: LogicType.PERSONAL.rawValue, variants: variants)
    }

    static func home() -> Logic {
        Logic(logicName: LogicType.HOME.rawValue)
    }

    static func home(variants: [String]) -> Logic {
        Logic(logicName: LogicType.HOME.rawValue, variants: variants)
    }

    private static func cartItemsToQueryParam(_ items: [CartItem]) -> String {
        var result = ""
        for i in items.indices {
            if (i != 0) {
                result.append("|")
            }
            result.append(cartItemToQueryParam(items[i]))
        }
        return result
    }

    private static func cartItemToQueryParam(_ cartItem: CartItem) -> String {
        "i:\(cartItem.itemId),p:\(cartItem.price),q:\(cartItem.quantity)"
    }
}
