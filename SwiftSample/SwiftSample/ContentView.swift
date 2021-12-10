//
//  Created by Emarsys on 2021. 12. 07..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginData: LoginData
    
    var body: some View {
        TabView {
            DashboardView()
                .environmentObject(loginData)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Dashboard")
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
