//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation
import EmarsysSDKExposed

@objc public protocol LogLevelProtocol: EMSLogLevelProtocol {

    var level: String { get set }

}
