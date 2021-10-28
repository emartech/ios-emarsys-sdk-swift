//
//  Copyright (c)  Emarys on 2021. 10. 26..
//

import Foundation

@objc public protocol ConfigApi {

    var applicationCode: String { get }

    var merchantId: String { get }

    var contactFieldId: Int { get }

    var hardwareId: String { get }

    var languageCode: String { get }

    var pushSettings: [String: Any] { get }

    var sdkVersion: String { get }

    func changeApplicationCode(_ applicationCode: String?) async throws

    func changeMerchantId(_ merchantId: String?) async throws

}
