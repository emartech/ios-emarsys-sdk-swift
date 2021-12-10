//
//  Created by Emarsys on 2021. 12. 07..
//

import Foundation
import UIKit
import EmarsysSDKSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var loginData: LoginData!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let applicationCode = "EMS11-C3FD3"
        let merchantId = "1428C8EE286EC34B"
        let config = Config(applicationCode: applicationCode,
                            merchantId: merchantId)
        loginData = LoginData(applicationCode: applicationCode,
                              merchantId: merchantId)
        
        Task {
            do {
                try await SwiftEmarsys.setup(config)
                
                loginData.isLoggedIn = false
                loginData.contactFieldValue = ""
                loginData.contactFieldId = ""
                loginData.hwid = await SwiftEmarsys.config.hardwareId
                loginData.languageCode = await SwiftEmarsys.config.languageCode
                loginData.pushSettings = [:]
                loginData.pushToken = ""
                loginData.sdkVersion = await SwiftEmarsys.config.sdkVersion
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Task {
            do {
                try await SwiftEmarsys.push.setPushToken(deviceToken)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
