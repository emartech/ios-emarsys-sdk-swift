//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation

@objc public protocol InAppApi {

    var eventPublisher: EventPublisher { get }

    var isPaused: Bool { get }

    func pause() async

    func resume() async

}
