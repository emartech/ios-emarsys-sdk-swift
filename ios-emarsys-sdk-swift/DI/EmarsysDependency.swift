//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed

protocol EmarsysDependency {
    var coreQueue: EMSOperationQueue { mutating get }
    var endpoint: EMSEndpoint { mutating get }
    var urlSession: URLSession { mutating get }
    var uuidProvider: EMSUUIDProvider { mutating get }
    var timeStampProvider: EMSTimestampProvider { mutating get }
    var dbHelper: EMSSQLiteHelper { mutating get }
    var deviceInfo: EMSDeviceInfo { mutating get }
    var shardRepository: EMSShardRepositoryProtocol { mutating get }
    var requestRepository: EMSRequestModelRepositoryProtocol { mutating get }
    var logger: EMSLogger { mutating get }
    var predictTrigger: EMSDBTriggerProtocol { mutating get }
    var loggerTrigger: EMSDBTriggerProtocol { mutating get }
    var restClient: EMSRESTClient { mutating get }
    var storage: EMSStorage { mutating get }
    var crypto: EMSCrypto { mutating get }
    var requestManager: EMSRequestManager { mutating get }
    var requestFactory: EMSRequestFactory { mutating get }
    var meRequestContext: MERequestContext { mutating get }
    var predictRequestContext: PRERequestContext { mutating get }
    var contactTokenResponseHandler: EMSContactTokenResponseHandler { mutating get }
    var worker: EMSWorkerProtocol { mutating get }
    var connectionWatchdog: EMSConnectionWatchdog  { mutating get }
    var completionMiddleware: EMSCompletionMiddleware { mutating get }
    var buttonClickRepository: MEButtonClickRepository { mutating get }
    var sessionIdHolder: EMSSessionIdHolder { mutating get }
    var notificationCenterManager: EMSNotificationCenterManager { mutating get }
    var responseHandlers: [EMSAbstractResponseHandler] { mutating get }
    var appStartBlockProvider: EMSAppStartBlockProvider { mutating get }
    var deviceInfoClient: EMSDeviceInfoClientProtocol { mutating get }
    var locationManager: CLLocationManager { mutating get }
    var mobileEngageRouterLogicBlock: RouterLogicBlock { mutating get }
    var predictEngageRouterLogicBlock: RouterLogicBlock { mutating get }
    var session: EMSSession { mutating get }
    var onEventActionFactory: EMSActionFactory { mutating get }
    var actionFactory: EMSActionFactory { mutating get }

    var mobileEngage: MobileEngageApi { mutating get }
    var loggingMobileEngage: MobileEngageApi { mutating get }
    var deepLink: DeepLinkApi { mutating get }
    var loggingDeepLink: DeepLinkApi { mutating get }
    var push: PushApi { mutating get }
    var loggingPush: PushApi { mutating get }
    var iam: InAppApi { mutating get }
    var loggingIam: InAppApi { mutating get }
    var predict: PredictApi { mutating get }
    var loggingPredict: PredictApi { mutating get }
    var geofence: GeofenceApi { mutating get }
    var loggingGeofence: GeofenceApi { mutating get }
    var inbox: InboxApi { mutating get }
    var loggingInbox: InboxApi { mutating get }
    var onEventAction: OnEventActionApi { mutating get }
    var loggingOnEventAction: OnEventActionApi { mutating get }
    var config: ConfigApi { mutating get }
    
}
