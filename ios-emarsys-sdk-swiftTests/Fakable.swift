//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation

protocol Fakable {
    
    var callHandler: CallHandler? { get set }
    
}

extension Fakable {
    
    var callHandler: CallHandler? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return CallHandlerHolder.callHandlers[tmpAddress]
        }
        set {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            CallHandlerHolder.callHandlers[tmpAddress] = newValue
        }
    }
}

fileprivate struct CallHandlerHolder {
    fileprivate static var callHandlers = [String: CallHandler]()
}
