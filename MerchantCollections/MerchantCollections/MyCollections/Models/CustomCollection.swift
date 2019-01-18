//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


struct CustomCollection: Codable {
    let id: UInt64
    let handle: String
    let title: String
    let bodyHtml: String
    // TODO: add Image struct
}

extension CustomCollection {
    struct Container: Codable {
        let customCollections: [CustomCollection]
    }
}
