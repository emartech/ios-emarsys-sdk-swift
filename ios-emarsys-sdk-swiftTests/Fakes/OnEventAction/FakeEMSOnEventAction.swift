//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

public class FakeEMSOnEventAction: NSObject, EMSOnEventActionProtocol {

    public var eventHandler: EMSEventHandlerBlock?

}