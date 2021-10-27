//
//  Created by Emarsys on 2021. 10. 27..
//

import Foundation

@objc public class NotificationInformation: NSObject {
    
    private var innerCampaignId: String
    
    @objc public var campaignId: String {
        get {
            innerCampaignId
        }
    }
    
    public init(_ campaignId: String) {
        self.innerCampaignId = campaignId
    }
    
}
