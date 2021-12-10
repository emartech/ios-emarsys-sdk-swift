//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation

class LoginData: ObservableObject {
    
    @Published var isLoggedIn : Bool
    @Published var contactFieldValue: String
    @Published var contactFieldId : String
    @Published var applicationCode : String
    @Published var merchantId : String
    @Published var hwid : String
    @Published var languageCode: String = "en-US"
    @Published var pushSettings: Dictionary<String, String> = ["notificationEnabled": "true",
                                                               "authorizationStatus": "authorized",
                                                               "soundSettings": "soundsetting"]
    @Published var pushToken: String
    @Published var sdkVersion: String
    
    init(isLoggedIn: Bool = false,
         contactFieldValue: String? = "",
         contactFieldId: String? = "",
         applicationCode: String? = "",
         merchantId: String? = "",
         hwId: String = "",
         languageCode: String = "",
         pushSettings: Dictionary<String, String> = [:],
         pushToken: String = "",
         sdkVersion: String = "") {
        self.isLoggedIn = isLoggedIn
        self.contactFieldValue = contactFieldValue ?? ""
        self.contactFieldId = contactFieldId ?? ""
        self.applicationCode = applicationCode ?? ""
        self.merchantId = merchantId ?? ""
        self.hwid = hwId
        self.languageCode = languageCode
        self.pushSettings = pushSettings
        self.pushToken = pushToken
        self.sdkVersion = sdkVersion
    }
}
