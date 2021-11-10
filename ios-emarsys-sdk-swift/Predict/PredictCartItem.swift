//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

class PredictCartItem: NSObject, CartItem {
    var predictItemId: String
    var predictPrice: Double
    var predictQuantity: Double

    init(itemId: String, price: Double, quantity: Double) {
        predictItemId = itemId
        predictPrice = price
        predictQuantity = quantity
    }
    
    func itemId() -> String! {
        predictItemId
    }
    
    func price() -> Double {
        predictPrice
    }
    
    func quantity() -> Double {
        predictQuantity
    }
}