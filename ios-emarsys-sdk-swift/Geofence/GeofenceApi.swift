//
//  Copyright (c)  Emarsys on 2021. 10. 26..
//

import Foundation

@objc public protocol GeofenceApi {

    var eventPublisher: EventPublisher { get }

    var initialEnterTriggerEnabled: Bool { get set }

    var isEnabled: Bool { get }

    func requestAlwaysAuthorization() async throws

    func registeredGeofences() async -> [Geofence]

    func enable() async throws

    func disable() async

}