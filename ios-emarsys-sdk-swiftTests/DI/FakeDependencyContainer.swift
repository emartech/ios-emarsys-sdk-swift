//
//  Copyright © 2021. Emarsys. All rights reserved.
//

import Foundation
import EmarsysSDKExposed
@testable import ios_emarsys_sdk_swift

@SdkActor
struct FakeDependencyContainer: EmarsysDependency {

    private var container: EmarsysContainer

    let coreQueue: EMSOperationQueue
    let endpoint: EMSEndpoint
    let urlSession: URLSession
    let uuidProvider: EMSUUIDProvider
    let timeStampProvider: EMSTimestampProvider
    let dbHelper: EMSSQLiteHelper
    let deviceInfo: EMSDeviceInfo
    let shardRepository: EMSShardRepositoryProtocol
    let requestRepository: EMSRequestModelRepositoryProtocol
    let logger: EMSLogger
    let predictTrigger: EMSDBTriggerProtocol
    let loggerTrigger: EMSDBTriggerProtocol
    let restClient: EMSRESTClient
    let storage: EMSStorage
    let crypto: EMSCrypto
    let requestManager: EMSRequestManager
    let requestFactory: EMSRequestFactory
    let meRequestContext: MERequestContext
    let predictRequestContext: PRERequestContext
    let contactTokenResponseHandler: EMSContactTokenResponseHandler
    let worker: EMSWorkerProtocol
    let connectionWatchdog: EMSConnectionWatchdog
    let completionMiddleware: EMSCompletionMiddleware
    let buttonClickRepository: MEButtonClickRepository
    let sessionIdHolder: EMSSessionIdHolder
    let notificationCenterManager: EMSNotificationCenterManager
    let responseHandlers: [EMSAbstractResponseHandler]
    let appStartBlockProvider: EMSAppStartBlockProvider
    let deviceInfoClient: EMSDeviceInfoClientProtocol
    let locationManager: CLLocationManager
    let session: EMSSession
    let onEventActionFactory: EMSActionFactory
    let actionFactory: EMSActionFactory
    let mobileEngage: MobileEngageApi
    let loggingMobileEngage: MobileEngageApi
    let deepLink: DeepLinkApi
    let loggingDeepLink: DeepLinkApi
    let push: PushApi
    let loggingPush: PushApi
    let iam: InAppApi
    let loggingIam: InAppApi
    let predict: PredictApi
    let loggingPredict: PredictApi
    let geofence: GeofenceApi
    let loggingGeofence: GeofenceApi
    let inbox: InboxApi
    let loggingInbox: InboxApi
    let onEventAction: OnEventActionApi
    let loggingOnEventAction: OnEventActionApi
    let config: ConfigApi

    init(container: EmarsysContainer,
         coreQueue: EMSOperationQueue? = nil,
         endpoint: EMSEndpoint? = nil,
         urlSession: URLSession? = nil,
         uuidProvider: EMSUUIDProvider? = nil,
         timeStampProvider: EMSTimestampProvider? = nil,
         dbHelper: EMSSQLiteHelper? = nil,
         deviceInfo: EMSDeviceInfo? = nil,
         shardRepository: EMSShardRepositoryProtocol? = nil,
         requestRepository: EMSRequestModelRepositoryProtocol? = nil,
         logger: EMSLogger? = nil,
         predictTrigger: EMSDBTriggerProtocol? = nil,
         loggerTrigger: EMSDBTriggerProtocol? = nil,
         restClient: EMSRESTClient? = nil,
         storage: EMSStorage? = nil,
         crypto: EMSCrypto? = nil,
         requestManager: EMSRequestManager? = nil,
         requestFactory: EMSRequestFactory? = nil,
         meRequestContext: MERequestContext? = nil,
         predictRequestContext: PRERequestContext? = nil,
         contactTokenResponseHandler: EMSContactTokenResponseHandler? = nil,
         worker: EMSWorkerProtocol? = nil,
         connectionWatchdog: EMSConnectionWatchdog? = nil,
         completionMiddleware: EMSCompletionMiddleware? = nil,
         buttonClickRepository: MEButtonClickRepository? = nil,
         sessionIdHolder: EMSSessionIdHolder? = nil,
         notificationCenterManager: EMSNotificationCenterManager? = nil,
         responseHandlers: [EMSAbstractResponseHandler]? = nil,
         appStartBlockProvider: EMSAppStartBlockProvider? = nil,
         deviceInfoClient: EMSDeviceInfoClientProtocol? = nil,
         locationManager: CLLocationManager? = nil,
         session: EMSSession? = nil,
         onEventActionFactory: EMSActionFactory? = nil,
         actionFactory: EMSActionFactory? = nil,
         mobileEngage: MobileEngageApi? = nil,
         loggingMobileEngage: MobileEngageApi? = nil,
         deepLink: DeepLinkApi? = nil,
         loggingDeepLink: DeepLinkApi? = nil,
         push: PushApi? = nil,
         loggingPush: PushApi? = nil,
         iam: InAppApi? = nil,
         loggingIam: InAppApi? = nil,
         predict: PredictApi? = nil,
         loggingPredict: PredictApi? = nil,
         geofence: GeofenceApi? = nil,
         loggingGeofence: GeofenceApi? = nil,
         inbox: InboxApi? = nil,
         loggingInbox: InboxApi? = nil,
         onEventAction: OnEventActionApi? = nil,
         loggingOnEventAction: OnEventActionApi? = nil,
         config: ConfigApi? = nil) {
        self.container = container
        self.coreQueue = coreQueue != nil ? coreQueue! : self.container.coreQueue
        self.endpoint = endpoint != nil ? endpoint! : self.container.endpoint
        self.urlSession = urlSession != nil ? urlSession! : self.container.urlSession
        self.uuidProvider = uuidProvider != nil ? uuidProvider! : self.container.uuidProvider
        self.timeStampProvider = timeStampProvider != nil ? timeStampProvider! : self.container.timeStampProvider
        self.dbHelper = dbHelper != nil ? dbHelper! : self.container.dbHelper
        self.deviceInfo = deviceInfo != nil ? deviceInfo! : self.container.deviceInfo
        self.shardRepository = shardRepository != nil ? shardRepository! : self.container.shardRepository
        self.requestRepository = requestRepository != nil ? requestRepository! : self.container.requestRepository
        self.logger = logger != nil ? logger! : self.container.logger
        self.predictTrigger = predictTrigger != nil ? predictTrigger! : self.container.predictTrigger
        self.loggerTrigger = loggerTrigger != nil ? loggerTrigger! : self.container.loggerTrigger
        self.restClient = restClient != nil ? restClient! : self.container.restClient
        self.storage = storage != nil ? storage! : self.container.storage
        self.crypto = crypto != nil ? crypto! : self.container.crypto
        self.requestManager = requestManager != nil ? requestManager! : self.container.requestManager
        self.requestFactory = requestFactory != nil ? requestFactory! : self.container.requestFactory
        self.meRequestContext = meRequestContext != nil ? meRequestContext! : self.container.meRequestContext
        self.predictRequestContext = predictRequestContext != nil ? predictRequestContext! : self.container.predictRequestContext
        self.contactTokenResponseHandler = contactTokenResponseHandler != nil ? contactTokenResponseHandler! : self.container.contactTokenResponseHandler
        self.worker = worker != nil ? worker! : self.container.worker
        self.connectionWatchdog = connectionWatchdog != nil ? connectionWatchdog! : self.container.connectionWatchdog
        self.completionMiddleware = completionMiddleware != nil ? completionMiddleware! : self.container.completionMiddleware
        self.buttonClickRepository = buttonClickRepository != nil ? buttonClickRepository! : self.container.buttonClickRepository
        self.sessionIdHolder = sessionIdHolder != nil ? sessionIdHolder! : self.container.sessionIdHolder
        self.notificationCenterManager = notificationCenterManager != nil ? notificationCenterManager! : self.container.notificationCenterManager
        self.responseHandlers = responseHandlers != nil ? responseHandlers! : self.container.responseHandlers
        self.appStartBlockProvider = appStartBlockProvider != nil ? appStartBlockProvider! : self.container.appStartBlockProvider
        self.deviceInfoClient = deviceInfoClient != nil ? deviceInfoClient! : self.container.deviceInfoClient
        self.locationManager = locationManager != nil ? locationManager! : self.container.locationManager
        self.session = session != nil ? session! : self.container.session
        self.onEventActionFactory = onEventActionFactory != nil ? onEventActionFactory! : self.container.onEventActionFactory
        self.actionFactory = actionFactory != nil ? actionFactory! : self.container.actionFactory
        self.mobileEngage = mobileEngage != nil ? mobileEngage! : self.container.mobileEngage
        self.loggingMobileEngage = loggingMobileEngage != nil ? loggingMobileEngage! : self.container.loggingMobileEngage
        self.deepLink = deepLink != nil ? deepLink! : self.container.deepLink
        self.loggingDeepLink = loggingDeepLink != nil ? loggingDeepLink! : self.container.loggingDeepLink
        self.push = push != nil ? push! : self.container.push
        self.loggingPush = loggingPush != nil ? loggingPush! : self.container.loggingPush
        self.iam = iam != nil ? iam! : self.container.iam
        self.loggingIam = loggingIam != nil ? loggingIam! : self.container.loggingIam
        self.predict = predict != nil ? predict! : self.container.predict
        self.loggingPredict = loggingPredict != nil ? loggingPredict! : self.container.loggingPredict
        self.geofence = geofence != nil ? geofence! : self.container.geofence
        self.loggingGeofence = loggingGeofence != nil ? loggingGeofence! : self.container.loggingGeofence
        self.inbox = inbox != nil ? inbox! : self.container.inbox
        self.loggingInbox = loggingInbox != nil ? loggingInbox! : self.container.loggingInbox
        self.onEventAction = onEventAction != nil ? onEventAction! : self.container.onEventAction
        self.loggingOnEventAction = loggingOnEventAction != nil ? loggingOnEventAction! : self.container.loggingOnEventAction
        self.config = config != nil ? config! : self.container.config
    }
}
