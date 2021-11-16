//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
@testable import EmarsysSDKExposed
import ios_emarsys_sdk_swift

@objc public class FakeEMSInApp: NSObject, EMSInAppProtocol {
    public var eventHandler: EMSEventHandlerBlock!
    var callHandler: (() -> ())!
    var isPausedValue: Bool = true


    public func pause() {
        self.callHandler()
    }

    public func resume() {
        self.callHandler()

    }

    public func isPaused() -> Bool {
        self.callHandler()
        return self.isPausedValue
    }

}
