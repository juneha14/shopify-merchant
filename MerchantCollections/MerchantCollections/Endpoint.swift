//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


struct Endpoint {
    enum URLError: Error {
        case invalidURL
    }

    let path: String
    let queryItems: [URLQueryItem]

   
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "shopicruit.myshopify.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
