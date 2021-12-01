//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

class DependencyInjection {

    private static var container: EmarsysDependency?

    static func setup(_ dependencyContainer: EmarsysDependency) {
        if(container == nil) {
            container = dependencyContainer
        }
    }

    static func teardown() {
        self.container = nil
    }

    static func dependencyContainer() async throws -> EmarsysDependency {
        try await getNilSafeDependencyContainer()
    }

    static func mobileEngage() async throws -> MobileEngageApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.mobileEngage : await dependencyContainer.loggingMobileEngage
    }

    static func push() async throws -> PushApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.push : await dependencyContainer.loggingPush
    }

    static func deepLink() async throws -> DeepLinkApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.deepLink : await dependencyContainer.loggingDeepLink
    }

    static func inApp() async throws -> InAppApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.iam : await dependencyContainer.loggingIam
    }

    static func predict() async throws -> PredictApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isPredictEnabled() ? await dependencyContainer.predict : await dependencyContainer.loggingPredict
    }

    static func geofence() async throws -> GeofenceApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.geofence : await dependencyContainer.loggingGeofence
    }

    static func inbox() async throws -> InboxApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.inbox : await dependencyContainer.loggingInbox
    }

    static func onEventAction() async throws -> OnEventActionApi {
        var dependencyContainer = try await getNilSafeDependencyContainer()
        return isMobileEngageEnabled() ? await dependencyContainer.onEventAction : await dependencyContainer.loggingOnEventAction
    }
    
    private static func getNilSafeDependencyContainer() async throws -> EmarsysDependency {
        guard let dependencyContainer = DependencyInjection.container else {
            throw SetupError.dependencyContainer
        }
        return dependencyContainer
    }
    
    private static func isMobileEngageEnabled() -> Bool {
        MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage)
    }
    
    private static func isPredictEnabled() -> Bool {
        MEExperimental.isFeatureEnabled(EMSInnerFeature.predict)
    }
}
