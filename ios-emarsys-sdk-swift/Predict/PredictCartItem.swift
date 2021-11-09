//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

class PredictCartItem: CartItem {
    var itemId: String
    var price: Double
    var quantity: Double

    init(itemId: String, price: Double, quantity: Double) {
        self.itemId = itemId
        self.price = price
        self.quantity = quantity
    }

}