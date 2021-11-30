//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation
import Combine
import EmarsysSDKExposed

struct EmarsysContainer: EmarsysDependency {
    
    private var emarsysConfig: EMSConfig
    internal var completionMiddleware: EMSCompletionMiddleware = EMSCompletionMiddleware(successBlock: { requestId, response in },
                                                                                         errorBlock: { requestId, response in })
    
    private lazy var suiteNames = Constants.suiteNames
    
    lazy var clientServiceUrlProvider = EMSValueProvider(defaultValue: ServiceUrls.Defaults.client, valueKey: ServiceUrls.Keys.client)
    lazy var eventServiceUrlProvider = EMSValueProvider(defaultValue: ServiceUrls.Defaults.event, valueKey: ServiceUrls.Keys.event)
    lazy var predictUrlProvider = EMSValueProvider(defaultValue: ServiceUrls.Defaults.predict, valueKey: ServiceUrls.Keys.predict)
    lazy var deeplinkUrlProvider = EMSValueProvider(defaultValue: ServiceUrls.Defaults.deeplink, valueKey: ServiceUrls.Keys.deeplink)
    lazy var v3MessageInboxUrlProvider = EMSValueProvider(defaultValue: ServiceUrls.Defaults.messageInbox, valueKey: ServiceUrls.Keys.messageInbox)
    
    lazy var coreQueue: EMSOperationQueue = {
        var queue = EMSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .utility
        queue.name = "core_sdk_queue_\(self.uuidProvider.provideUUIDString())"
        return queue
    }()
    
    lazy var urlSession: URLSession = {
        var sessionConfiguration = URLSessionConfiguration()
        sessionConfiguration.timeoutIntervalForRequest = 30.0
        sessionConfiguration.httpCookieStorage = nil
        let session = URLSession(configuration: sessionConfiguration)
        return session
    }()
    
    lazy var meRequestContext: MERequestContext = MERequestContext(applicationCode: emarsysConfig.applicationCode,
                                                                   uuidProvider: self.uuidProvider,
                                                                   timestampProvider: self.timeStampProvider,
                                                                   deviceInfo: self.deviceInfo, storage: self.storage)
    lazy var predictRequestContext: PRERequestContext = PRERequestContext(timestampProvider: self.timeStampProvider,
                                                                          uuidProvider: self.uuidProvider,
                                                                          merchantId: emarsysConfig.merchantId,
                                                                          deviceInfo: self.deviceInfo)
    lazy var contactTokenResponseHandler: EMSContactTokenResponseHandler = EMSContactTokenResponseHandler(requestContext: self.meRequestContext, endpoint: self.endpoint)
    lazy var endpoint: EMSEndpoint = EMSEndpoint(clientServiceUrlProvider: self.clientServiceUrlProvider,
                                                 eventServiceUrlProvider: self.eventServiceUrlProvider,
                                                 predictUrlProvider: self.predictUrlProvider,
                                                 deeplinkUrlProvider: self.deeplinkUrlProvider,
                                                 v3MessageInboxUrlProvider: self.v3MessageInboxUrlProvider)
    lazy var uuidProvider: EMSUUIDProvider = EMSUUIDProvider()
    lazy var timeStampProvider: EMSTimestampProvider = EMSTimestampProvider()
    lazy var dbHelper: EMSSQLiteHelper = EMSSQLiteHelper(databasePath: Constants.dbPath,
                                                         schemaDelegate: EMSSqliteSchemaHandler())
    lazy var deviceInfo: EMSDeviceInfo = EMSDeviceInfo(sdkVersion: Constants.sdkVersion,
                                                       notificationCenter: UNUserNotificationCenter.current(),
                                                       storage: self.storage,
                                                       uuidProvider: self.uuidProvider)
    lazy var shardRepository: EMSShardRepositoryProtocol = EMSShardRepository(dbHelper: self.dbHelper)
    lazy var displayedIamRepository: MEDisplayedIAMRepository = MEDisplayedIAMRepository(dbHelper: self.dbHelper)
    lazy var logger: EMSLogger = EMSLogger(
        shardRepository: self.shardRepository,
        opertaionQueue: self.coreQueue,
        timestampProvider: self.timeStampProvider,
        uuidProvider: self.uuidProvider,
        storage: self.storage,
        wrapperChecker: EMSWrapperChecker(operationQueue: self.coreQueue,
                                          waiter: EMSDispatchWaiter()))
    lazy var loggerTrigger: EMSDBTriggerProtocol = EMSBatchingShardTrigger(repository: self.shardRepository,
                                                                           specification: EMSFilterByTypeSpecification(witType: "log_%%",
                                                                                                                       column: SchemaContract.Shard.ColumnName.type),
                                                                           mapper: EMSLogMapper(requestContext: self.meRequestContext, applicationCode: emarsysConfig.applicationCode, merchantId: emarsysConfig.merchantId),
                                                                           chunker: EMSListChunker(chunkSize: 10),
                                                                           predicate: (EMSCountPredicate(threshold: 10) as EMSPredicate<NSArray> as! EMSPredicate<AnyObject>),
                                                                           requestManager: self.requestManager,
                                                                           persistent: false,
                                                                           connectionWatchdog: self.connectionWatchdog)
    lazy var restClient: EMSRESTClient = EMSRESTClient(session: self.urlSession,
                                                       queue: self.coreQueue,
                                                       timestampProvider: self.timeStampProvider,
                                                       additionalHeaders: MEDefaultHeaders.additionalHeaders() as? [String: String],
                                                       requestModelMappers: [
                                                        EMSContactTokenMapper(requestContext: self.meRequestContext, endpoint: self.endpoint)
                                                       ],
                                                       responseHandlers: [],
                                                       mobileEngageBodyParser: EMSMobileEngageNullSafeBodyParser(endpoint: self.endpoint))
    lazy var storage: EMSStorage = EMSStorage(suiteNames: suiteNames, accessGroup: emarsysConfig.sharedKeychainAccessGroup)
    lazy var crypto: EMSCrypto = EMSCrypto()
    lazy var requestManager: EMSRequestManager = EMSRequestManager(coreQueue: self.coreQueue,
                                                                   completionMiddleware: self.completionMiddleware,
                                                                   restClient: self.restClient,
                                                                   worker: self.worker,
                                                                   requestRepository: self.requestRepository,
                                                                   shardRepository: self.shardRepository,
                                                                   proxyFactory: EMSCompletionProxyFactory(requestRepository: self.requestRepository,
                                                                                                           operationQueue: self.coreQueue,
                                                                                                           defaultSuccessBlock: self.completionMiddleware.successBlock,
                                                                                                           defaultErrorBlock: self.completionMiddleware.errorBlock,
                                                                                                           restClient: self.restClient,
                                                                                                           requestFactory: self.requestFactory,
                                                                                                           contactResponseHandler: self.contactTokenResponseHandler,
                                                                                                           endpoint: self.endpoint,
                                                                                                           storage: self.storage))
    lazy var requestFactory: EMSRequestFactory = EMSRequestFactory(requestContext: self.meRequestContext,
                                                                   endpoint: self.endpoint,
                                                                   buttonClickRepository: self.buttonClickRepository,
                                                                   sessionIdHolder: self.sessionIdHolder,
                                                                   storage: self.storage)
    lazy var worker: EMSWorkerProtocol = EMSDefaultWorker(operationQueue: self.coreQueue,
                                                          requestRepository: self.requestRepository,
                                                          connectionWatchdog: self.connectionWatchdog,
                                                          restClient: self.restClient,
                                                          errorBlock: self.completionMiddleware.errorBlock,
                                                          proxyFactory: EMSCompletionProxyFactory(requestRepository: self.requestRepository,
                                                                                                  operationQueue: self.coreQueue,
                                                                                                  defaultSuccessBlock: self.completionMiddleware.successBlock,
                                                                                                  defaultErrorBlock: self.completionMiddleware.errorBlock,
                                                                                                  restClient: self.restClient,
                                                                                                  requestFactory: self.requestFactory,
                                                                                                  contactResponseHandler: self.contactTokenResponseHandler,
                                                                                                  endpoint: self.endpoint,
                                                                                                  storage: self.storage))
    lazy var connectionWatchdog: EMSConnectionWatchdog = EMSConnectionWatchdog(reachability: EMSReachability(forInternetConnectionWith: self.coreQueue), operationQueue: self.coreQueue)
    lazy var buttonClickRepository: MEButtonClickRepository = MEButtonClickRepository(dbHelper: self.dbHelper)
    lazy var sessionIdHolder: EMSSessionIdHolder = EMSSessionIdHolder()
    lazy var notificationCenterManager: EMSNotificationCenterManager = EMSNotificationCenterManager(notificationCenter: NotificationCenter.default)
    lazy var requestModelRepositoryFactory = MERequestModelRepositoryFactory(inApp: self.meIAM,
                                                                             requestContext: self.meRequestContext,
                                                                             dbHelper: self.dbHelper,
                                                                             buttonClickRepository: self.buttonClickRepository,
                                                                             displayedIAMRepository: self.displayedIamRepository,
                                                                             endpoint: self.endpoint,
                                                                             operationQueue: self.coreQueue,
                                                                             storage: self.storage)
    
    lazy var requestRepository: EMSRequestModelRepositoryProtocol = self.requestModelRepositoryFactory!.create(withBatchCustomEventProcessing: true)
    lazy var predictTrigger: EMSDBTriggerProtocol = EMSBatchingShardTrigger(repository: self.shardRepository,
                                                                            specification: EMSFilterByTypeSpecification(witType: "predict_%%", column: SchemaContract.Shard.ColumnName.type),
                                                                            mapper: EMSPredictMapper(requestContext: self.predictRequestContext, endpoint: self.endpoint),
                                                                            chunker: EMSListChunker(chunkSize: 1),
                                                                            predicate: (EMSCountPredicate(threshold: 1) as EMSPredicate<NSArray> as! EMSPredicate<AnyObject>),
                                                                            requestManager: self.requestManager,
                                                                            persistent: true,
                                                                            connectionWatchdog: self.connectionWatchdog)
    lazy var responseHandlers: [EMSAbstractResponseHandler] = [
        MEIAMResponseHandler(inApp: self.meIAM),
        MEIAMCleanupResponseHandlerV3(buttonClickRepository: self.buttonClickRepository,
                                      display: self.displayedIamRepository,
                                      endpoint: self.endpoint),
        MEIAMCleanupResponseHandlerV4(buttonClickRepository: self.buttonClickRepository,
                                      display: self.displayedIamRepository,
                                      endpoint: self.endpoint),
        EMSDeviceEventStateResponseHandler(storage: self.storage,
                                           endpoint: self.endpoint),
        EMSVisitorIdResponseHandler(requestContext: self.predictRequestContext,
                                    endpoint: self.endpoint),
        EMSXPResponseHandler(requestContext: self.predictRequestContext,
                             endpoint: self.endpoint),
        EMSClientStateResponseHandler(requestContext: self.meRequestContext,
                                      endpoint: self.endpoint),
        EMSRefreshTokenResponseHandler(requestContext: self.meRequestContext,
                                       endpoint: self.endpoint),
        self.contactTokenResponseHandler,
        EMSOnEventResponseHandler(requestManager: self.requestManager,
                                  requestFactory: self.requestFactory,
                                  displayedIAMRepository: self.displayedIamRepository,
                                  actionFactory: self.onEventActionFactory,
                                  timestampProvider: self.timeStampProvider)
    ]
    lazy var appStartBlockProvider: EMSAppStartBlockProvider = EMSAppStartBlockProvider(requestManager: self.requestManager,
                                                                                        requestFactory: self.requestFactory,
                                                                                        requestContext: self.meRequestContext,
                                                                                        deviceInfoClient: self.deviceInfoClient,
                                                                                        configInternal: self.emsConfigInternal,
                                                                                        geofenceInternal: self.emsGeofenceInternal,
                                                                                        sdkStateLogger: EMSSdkStateLogger(endpoint: self.endpoint,
                                                                                                                          meRequestContext: self.meRequestContext,
                                                                                                                          config: self.emarsysConfig,
                                                                                                                          storage: self.storage),
                                                                                        logger: self.logger)
    lazy var deviceInfoClient: EMSDeviceInfoClientProtocol = EMSDeviceInfoV3ClientInternal(requestManager: self.requestManager,
                                                                                           requestFactory: self.requestFactory,
                                                                                           deviceInfo: self.deviceInfo,
                                                                                           requestContext: self.meRequestContext)
    lazy var locationManager: CLLocationManager = CLLocationManager()
    lazy var mobileEngageRouterLogicBlock: RouterLogicBlock = {
        MEExperimental.isFeatureEnabled(EMSInnerFeature.mobileEngage)
    }
    lazy var predictEngageRouterLogicBlock: RouterLogicBlock = {
        MEExperimental.isFeatureEnabled(EMSInnerFeature.predict)
    }
    lazy var session: EMSSession = EMSSession(sessionIdHolder: self.sessionIdHolder,
                                              requestManager: self.requestManager,
                                              requestFactory: self.requestFactory,
                                              operationQueue: self.coreQueue,
                                              timestampProvider: self.timeStampProvider)
    lazy var onEventActionFactory: EMSActionFactory = EMSActionFactory(application: UIApplication.shared, mobileEngage: self.emsMobileEngage)
    lazy var actionFactory: EMSActionFactory = EMSActionFactory(application: UIApplication.shared, mobileEngage: self.emsMobileEngage)
    lazy var mobileEngage: MobileEngageApi = MobileEngageInternal(emsMobileEngage: self.emsMobileEngage)
    lazy var loggingMobileEngage: MobileEngageApi = MobileEngageLogger(emsLoggingMobileEngage: EMSLoggingMobileEngageInternal())
    lazy var deepLink: DeepLinkApi = DeepLinkInternal(emsDeepLink: EMSDeepLinkInternal(requestManager: requestManager, requestFactory: requestFactory))
    lazy var loggingDeepLink: DeepLinkApi = DeepLinkLogger(emsDeepLinkLogger: EMSLoggingDeepLinkInternal())
    lazy var push: PushApi = PushInternal(emsPush: self.emsPushInternal,
                                          silentNotificationEventStream: PassthroughSubject<Event, Error>(),
                                          silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>(),
                                          notificationEventStream: PassthroughSubject<Event, Error>(),
                                          notificationInformationStream: PassthroughSubject<NotificationInformation, Error>())
    lazy var loggingPush: PushApi = PushLogger(emsLoggingPush: EMSLoggingPushInternal(),
                                          silentNotificationEventStream: PassthroughSubject<Event, Error>(),
                                          silentNotificationInformationStream: PassthroughSubject<NotificationInformation, Error>(),
                                          notificationEventStream: PassthroughSubject<Event, Error>(),
                                          notificationInformationStream: PassthroughSubject<NotificationInformation, Error>())
    let inAppEventStream = PassthroughSubject<Event, Error>()
    lazy var iam: InAppApi = InAppInternal(emsInApp: self.meIAM, eventStream: inAppEventStream)
    lazy var loggingIam: InAppApi = InAppLogger(emsLoggingInApp: EMSLoggingInApp(), eventStream: inAppEventStream)
    lazy var predict: PredictApi = PredictInternal(emsPredict: EMSPredictInternal(requestContext: self.predictRequestContext,
                                                                                  requestManager: self.requestManager,
                                                                                  request: EMSPredictRequestModelBuilderProvider(requestContext: self.predictRequestContext,
                                                                                                                                 endpoint: self.endpoint),
                                                                                  productMapper: EMSProductMapper()))
    lazy var loggingPredict: PredictApi = PredictLogger(emsLoggingPredict: EMSLoggingPredictInternal())
    let geofenceEventStream = PassthroughSubject<Event, Error>()
    lazy var geofence: GeofenceApi = GeofenceInternal(emsGeofence: emsGeofenceInternal,
                                                      geofenceMapper: GeofenceMapper(),
                                                      eventStream: geofenceEventStream)
    lazy var loggingGeofence: GeofenceApi = GeofenceLogger(emsLoggingGeofence: EMSLoggingGeofenceInternal(),
                                                           eventStream: geofenceEventStream)
    lazy var inbox: InboxApi = InboxInternal(emsInbox: self.emsInbox)
    lazy var loggingInbox: InboxApi = InboxLogger(emsLoggingInbox: EMSLoggingInboxV3())
    lazy var onEventAction: OnEventActionApi = OnEventActionInternal(emsOnEventAction: self.emsOnEventAction, eventStream: PassthroughSubject<Event, Error>())
    lazy var loggingOnEventAction: OnEventActionApi = OnEventActionLogger(emsLoggingOnEventAction: EMSLoggingOnEventActionInternal(), eventStream: PassthroughSubject<Event, Error>())
    lazy var config: ConfigApi = ConfigInternal(emsConfig: self.emsConfigInternal)
    
    lazy var emsConfigInternal: EMSConfigInternal = EMSConfigInternal(requestManager: self.requestManager,
                                                                      meRequestContext: self.meRequestContext,
                                                                      preRequestContext: self.predictRequestContext,
                                                                      mobileEngage: self.emsMobileEngage,
                                                                      pushInternal: self.emsPushInternal,
                                                                      deviceInfo: self.deviceInfo,
                                                                      emarsysRequestFactory: EMSEmarsysRequestFactory(timestampProvider: self.timeStampProvider,
                                                                                                                      uuidProvider: self.uuidProvider,
                                                                                                                      endpoint: self.endpoint,
                                                                                                                      requestContext: self.meRequestContext),
                                                                      remoteConfigResponseMapper: EMSRemoteConfigResponseMapper(randomProvider: EMSRandomProvider(),
                                                                                                                                deviceInfo: self.deviceInfo),
                                                                      endpoint: self.endpoint,
                                                                      logger: self.logger,
                                                                      crypto: self.crypto,
                                                                      queue: self.coreQueue,
                                                                      waiter: EMSDispatchWaiter(),
                                                                      deviceInfoClient: self.deviceInfoClient)
    
    lazy var emsGeofenceInternal = EMSGeofenceInternal(requestFactory: self.requestFactory,
                                                       requestManager: self.requestManager,
                                                       responseMapper: EMSGeofenceResponseMapper(),
                                                       locationManager: self.locationManager,
                                                       actionFactory: self.actionFactory,
                                                       storage: self.storage,
                                                       queue: self.coreQueue)
    
    lazy var meIAM: MEInApp = {
        var meInApp = MEInApp(windowProvider: EMSWindowProvider(viewControllerProvider: EMSViewControllerProvider(),
                                                                sceneProvider: EMSSceneProvider(application: UIApplication.shared)),
                              mainWindowProvider: EMSMainWindowProvider(application: UIApplication.shared),
                              timestampProvider: self.timeStampProvider,
                              completionBlockProvider: EMSCompletionBlockProvider(operationQueue: self.coreQueue),
                              displayedIamRepository: self.displayedIamRepository,
                              buttonClickRepository: self.buttonClickRepository,
                              operationQueue: self.coreQueue)
        
        meInApp.inAppTracker = self.emsInAppInternal
        return meInApp
    }()
    
    lazy var emsInAppInternal: EMSInAppInternal = EMSInAppInternal(requestManager: self.requestManager,
                                                                   requestFactory: self.requestFactory,
                                                                   meInApp: self.meIAM,
                                                                   timestampProvider: self.timeStampProvider,
                                                                   uuidProvider: self.uuidProvider)
    
    lazy var emsPushInternal: EMSPushNotificationProtocol = EMSPushV3Internal(requestFactory: self.requestFactory,
                                                                              requestManager: self.requestManager,
                                                                              actionFactory: self.actionFactory,
                                                                              storage: self.storage,
                                                                              inAppInternal: self.emsInAppInternal,
                                                                              operationQueue: self.coreQueue)
    
    lazy var emsInbox: EMSInboxV3 = EMSInboxV3(requestFactory: self.requestFactory,
                                               requestManager: self.requestManager,
                                               inboxResultParser: EMSInboxResultParser())
    
    lazy var emsOnEventAction: EMSOnEventActionProtocol = EMSOnEventActionInternal(actionFactory: self.onEventActionFactory)
    
    lazy var emsMobileEngage: EMSMobileEngageProtocol = EMSMobileEngageV3Internal(requestFactory: self.requestFactory,
                                                                                  requestManager: self.requestManager,
                                                                                  requestContext: self.meRequestContext,
                                                                                  storage: self.storage,
                                                                                  session: self.session)
    
    init(_ config: Config) {
        self.emarsysConfig = EMSConfig.make { builder in
            if let applicationCode = config.applicationCode as? String {
                builder.setMobileEngageApplicationCode(applicationCode)
            }
            if let merchantId = config.merchantId as? String {
                builder.setMerchantId(merchantId)
            }
            if let experimentalFeatures = config.experimentalFeatures as? [EMSFlipperFeature]{
                builder.setExperimentalFeatures(experimentalFeatures)
            }
            if let enabledConsoleLogLevels = config.enabledConsoleLogLevels as? [EMSLogLevelProtocol] {
                builder.enableConsoleLogLevels(enabledConsoleLogLevels)
            }
            if let sharedKeychainAccessGroup = config.sharedKeychainAccessGroup as? String {
                builder.setSharedKeychainAccessGroup(sharedKeychainAccessGroup)
            }
        }
    }
}
