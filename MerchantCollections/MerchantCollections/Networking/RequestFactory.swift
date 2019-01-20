//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


final class RequestFactory {
    static let accessTokenQueryItem = URLQueryItem(name: "access_token", value: "c32313df0d0ef512ca64d5b336a0d7c6")


    // MARK: API

    static func myCollections(page: Int = 1) -> Endpoint {
        let path = "/admin/custom_collections.json"
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            RequestFactory.accessTokenQueryItem
        ]

        return Endpoint(path: path, queryItems: queryItems)
    }

    static func collects(page: Int = 1, forId id: UInt64) -> Endpoint {
        let path = "/admin/collects.json"
        let queryItems = [
            URLQueryItem(name: "collection_id", value: String(id)),
            URLQueryItem(name: "page", value: String(page)),
            RequestFactory.accessTokenQueryItem
        ]

        return Endpoint(path: path, queryItems: queryItems)
    }

    static func products(page: Int = 1, forProductQuery query: String) -> Endpoint {
        let path = "/admin/products.json"
        let queryItems = [
            URLQueryItem(name: "ids", value: query),
            URLQueryItem(name: "page", value: String(page)),
            RequestFactory.accessTokenQueryItem
        ]

        return Endpoint(path: path, queryItems: queryItems)
    }
}
