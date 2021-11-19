//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

enum ServiceUrls {
    enum Defaults {
        static let client = "https://me-client.eservice.emarsys.net"
        static let event = "https://mobile-events.eservice.emarsys.net"
        static let predict = "https://recommender.scarabresearch.com"
        static let deeplink = "https://deep-link.eservice.emarsys.net/api/clicks"
        static let messageInbox = "https://me-inbox.eservice.emarsys.net"
    }

    enum Keys {
        static let client = "CLIENT_SERVICE_URL"
        static let event = "EVENT_SERVICE_URL"
        static let predict = "PREDICT_URL"
        static let deeplink = "DEEPLINK_URL"
        static let messageInbox = "V3_MESSAGE_INBOX_URL"
    }
}
