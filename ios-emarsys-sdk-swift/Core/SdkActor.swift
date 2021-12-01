//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import UIKit

@globalActor
struct SdkActor {
    actor ActorType { }

    static let shared: ActorType = ActorType()
    
    static let uiApplication: UIApplication = UIApplication.shared
}
