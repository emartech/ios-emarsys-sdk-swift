//
//  Created by Emarsys on 2021. 12. 07..
//

import SwiftUI

@main
struct SwiftSampleApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.appDelegate.loginData)
        }
    }
}
