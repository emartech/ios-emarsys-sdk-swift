//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import XCTest
import EmarsysSDKExposed
@testable import ios_emarsys_sdk_swift

extension XCTestCase {
    
    func assertField<T: Equatable>(of object: Any, with field: String, isEqual withObject: T) throws {
        let mirror = Mirror(reflecting: object)
        let property = mirror.children.first(where: { $0.label == field })?.value
        
        XCTAssertEqual(property as? T, withObject)
    }
    
    func field<T>(of object: Any, with fieldName: String) -> T? {
        let mirror = Mirror(reflecting: object)
        
        return mirror.children.first(where: { $0.label == fieldName })?.value as? T
    }

    func teardownEmarsys() {
        EMSDependencyInjection.dependencyContainer?.publicApiOperationQueue().waitUntilAllOperationsAreFinished()
        EMSDependencyInjection.dependencyContainer?.coreOperationQueue().waitUntilAllOperationsAreFinished()
        EMSDependencyInjection.dependencyContainer?.dbHelper().close()
        EMSDependencyInjection.dependencyContainer?.endpoint().reset()

        EMSDependencyInjection.dependencyContainer?.requestContext().reset()
        EMSDependencyInjection.dependencyContainer?.notificationCenterManager().removeHandlers()
        EMSDependencyInjection.tearDown()
        DependencyInjection.teardown()
        deleteRequestContextData()

        MEExperimental.disableFeature(EMSInnerFeature.mobileEngage)
        MEExperimental.disableFeature(EMSInnerFeature.eventServiceV4)
        MEExperimental.disableFeature(EMSInnerFeature.predict)
    }

    private func deleteRequestContextData() {
        let userDefaults = UserDefaults(suiteName: Constants.mobileEngageSuiteName)
        userDefaults!.removeObject(forKey: RequestContextKeys.MobileEngage.contactToken)
        userDefaults?.removeObject(forKey: RequestContextKeys.MobileEngage.clientState)
        userDefaults?.removeObject(forKey: RequestContextKeys.MobileEngage.contactFieldValue)
        userDefaults?.removeObject(forKey: RequestContextKeys.MobileEngage.refreshToken)
    }
}
