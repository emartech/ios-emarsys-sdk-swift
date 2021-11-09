//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

@objc public protocol CartItem {
    var itemId: String { get set }
    var price: Double { get set }
    var quantity: Double { get set }
}