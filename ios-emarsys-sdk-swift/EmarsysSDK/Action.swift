//
// Copyright (c)  Emarsys on 2021. 10. 28..
//

import Foundation

@objc public protocol Action {

    var id: String { get }

    var title: String { get }

    var type: String { get }

}