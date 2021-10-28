//
//  Created by Emarsys on 2021. 10. 26..
//

import Foundation

@objc public protocol InApp {

    var eventHandler: EventHandler { get set }

    func pause() async throws

    func resume() async throws

    func isPaused() async throws

}
