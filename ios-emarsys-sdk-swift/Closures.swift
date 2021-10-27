//
//  Created by Emarsys on 2021. 10. 27..
//

import Foundation

public typealias EventHandler = (_ eventName: String, _ payload: [String: Any]?) -> ()

public typealias NotificationInformationHandler = (_ notificationInformation: NotificationInformation) -> ()
