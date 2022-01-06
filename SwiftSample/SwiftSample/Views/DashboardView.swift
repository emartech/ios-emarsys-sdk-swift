//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import SwiftUI
import EmarsysSDKSwift
import AuthenticationServices

struct DashboardView: View {
    
    @EnvironmentObject var loginData: LoginData
    @State var isGeofenceEnabled: Bool = false
    @State var showSetupChangeMessage: Bool = false
    @State var messageText: String = ""
    @State var messageColor: UIColor = .green
    @State var showLoginMessage: Bool = false
    
    @State var changeEnv: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    Text("Change SDK setup")
                        .bold()
                    
                    if(self.showSetupChangeMessage) {
                        Text(self.messageText).foregroundColor(Color(self.messageColor))
                    }
                    
                    FloatingTextField(title: "ApplicationCode", text: $loginData.applicationCode)
                    
                    FloatingTextField(title: "MerchantId", text: $loginData.merchantId)
                    
                    HStack {
                        Spacer()
                        Button(action: self.changeConfig) {
                            Text("Change")
                        }
                    }
                }.padding()
                
                Divider().background(Color.black).padding(.horizontal)
                
                VStack(spacing: 15) {
                    Text("Push token")
                        .bold()
                    
                    HStack {
                        Spacer()
                        Button(action: self.setPushTokenButtonClicked) {
                            Text("Set")
                        }
                        Spacer()
                        Button(action: self.copyPushTokenButtonClicked) {
                            Text("Copy")
                        }
                        Spacer()
                    }
                }
                
                Divider().background(Color.black).padding(.horizontal)
                
                VStack(spacing: 15) {
                    Text("Geofence").bold()
                    Button(action: self.requestLocationPermission) {
                        Text("Request location permissions")
                    }
                    HStack {
                        Text("Enabled")
                        Toggle("Enabled", isOn: $isGeofenceEnabled).labelsHidden().onTapGesture {
                            if(self.isGeofenceEnabled) {
                                Task {
                                    await SwiftEmarsys.geofence.disable()
                                }
                            } else {
                                Task {
                                    do {
                                        try await SwiftEmarsys.geofence.enable()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                    Text("Registered geofences").bold()
                    Button(action: self.getRegisteredGeofences) {
                        Text("Get registered geofences")
                    }
                }
                
                Divider().background(Color.black).padding(.horizontal)
                
                VStack {
                    Text("InApp Demo")
                        .fontWeight(.bold)
                    Button {
                        self.trackCustomEventForInApp()
                    } label: {
                        Text("Get me an InApp")
                    }
                    .padding()
                }
                
                Divider().background(Color.black).padding(.horizontal)
                
                VStack(spacing: 20) {
                    Text("Contact identification")
                        .bold()
                    
                    if(self.showLoginMessage) {
                        Text(self.messageText).foregroundColor(Color(self.messageColor))
                    }
                    
                    if(self.loginData.isLoggedIn == false) {
                        HStack {
                            FloatingTextField(title: "CFId", text: $loginData.contactFieldId)
                                .frame(width: 100)
                            
                            FloatingTextField(title: "ContactFieldValue", text: $loginData.contactFieldValue).accessibility(identifier: "customFieldValue")
                        }
                    }
                    
                    HStack() {
                        Spacer()
                        Button(action: {
                            self.loginButtonClicked()
                        }) {
                            self.loginButtonText()
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func trackCustomEventForInApp() {
        Task {
            try await SwiftEmarsys.trackCustomEvent("mysy2", eventAttributes: nil)
        }
    }
    
    func loginButtonText() -> Text {
        let buttonText = self.loginData.isLoggedIn ? "Logout" : "Login"
        return Text("\(buttonText)")
    }
    
    func loginButtonClicked() {
        if self.loginData.isLoggedIn == false {
            if let contactFieldId = getContactFieldId() {
                Task {
                    do {
                        try await SwiftEmarsys.setContact(getContactFieldId()!, loginData.contactFieldValue)
                        self.loginData.contactFieldId = contactFieldId.stringValue
                        self.loginData.isLoggedIn = true
                        showMessage(successful: true)
                    } catch {
                        print(error.localizedDescription)
                        showMessage(successful: false)
                    }
                }
            } else {
                showMessage(successful: false)
            }
        } else {
            Task {
                do {
                    try await SwiftEmarsys.clearContact()
                } catch {
                    showMessage(successful: false)
                }
            }
        }
        self.showLoginMessage = true
    }
    
    func changeConfig() {
        Task {
            if !self.loginData.applicationCode.isEmpty {
                do {
                   try await SwiftEmarsys.config.changeApplicationCode(self.loginData.applicationCode)
                    self.showMessage(successful: true)
                } catch {
                    self.messageText = "There was an error while changing ApplicationCode"
                    self.showMessage(successful: false)
                }
            }
            if !self.loginData.merchantId.isEmpty {
                do {
                    try await SwiftEmarsys.config.changeMerchantId(self.loginData.merchantId)
                    self.showMessage(successful: true)
                } catch {
                    self.messageText = "There was an error while changing MerchantId"
                    self.showMessage(successful: false)
                }
            }
            self.showSetupChangeMessage = true
        }
    }
    
    func getContactFieldId() -> NSNumber? {
        var result: NSNumber? = nil
        if let myInteger = Int(self.loginData.contactFieldId) {
            result = NSNumber(value:myInteger)
        } else {
            self.showMessage(successful: false)
        }
        
        return result
    }
    
    func doEnvironmentChange() {
        if(changeEnv) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                exit(0)
            }
        }
    }
    
    func showMessage(successful: Bool) {
        if(successful) {
            self.messageText = "Successful"
            self.messageColor = .green
        } else {
            self.messageText = "Something went wrong"
            self.messageColor = .red
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
        hideMessage()
    }
    
    func hideMessage() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.showSetupChangeMessage = false
            self.showLoginMessage = false
        }
    }
    
    func setPushTokenButtonClicked() {
        if let deviceToken = self.loginData.pushToken {
            Task {
                do {
                    try await SwiftEmarsys.push.setPushToken(deviceToken)
                } catch {
                    
                }
            }
        }
    }
    
    func copyPushTokenButtonClicked() {
        if (self.loginData.pushToken != nil) {
            UIPasteboard.general.string = self.loginData.pushToken!.deviceTokenString()
        }
    }
    
    func requestLocationPermission() {
        Task {
            await SwiftEmarsys.geofence.requestAlwaysAuthorization()
        }
    }
    
    func getRegisteredGeofences() {
        if (loginData.isLoggedIn == true && isGeofenceEnabled == true) {
            Task {
                async let registeredGeofences = SwiftEmarsys.geofence.registeredGeofences()
                print(await registeredGeofences)
            }
        }
    }
}



struct DashboardView_Previews: PreviewProvider {
    
    static var previews: some View {
        DashboardView()
            .environmentObject(LoginData(isLoggedIn: false,
                                         contactFieldValue: "test@test.com",
                                         contactFieldId: "2545",
                                         applicationCode: "EMS11-C3FD3",
                                         merchantId: "testMerchantId"))
    }
}
