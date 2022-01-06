//
//  Created by Emarsys on 2022. 01. 06..
//

import Foundation

extension Data {
    
    func deviceTokenString() -> String {
        return self.map {
            String(format: "%02.2hhx", $0)
        }.joined()
    }
}
