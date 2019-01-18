//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


class CollectionService {
    private let dataLoader: DataLoader

    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }


    // MARK: API

    func loadMyCollections(completion: @escaping (Result<[CustomCollection]>) -> Void) {
        let endpoint = endpointForMyCollections()

        dataLoader.loadData(from: endpoint) { result in
            do {
                let collectionsContainer = try result.decoded() as CustomCollection.Container
                let collections = collectionsContainer.customCollections
                completion(.success(collections))
            } catch {
                completion(.failure(error))
            }
        }
    }


    // MARK: Helpers

    private func endpointForMyCollections() -> Endpoint {
        let path = "/admin/custom_collections.json"

        // TODO: handle pagination and better access token
        let queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "access_token", value: "c32313df0d0ef512ca64d5b336a0d7c6")
        ]

        return Endpoint(path: path, queryItems: queryItems)
    }
}
