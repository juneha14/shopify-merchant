//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


enum Outcome<Value> {
    case success(Value)
    case failure(Error)
}


class CollectionService {
    private let dataLoader: DataLoader

    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }


    // MARK: API

    func loadMyCollections(completion: @escaping (Outcome<[CustomCollection]>) -> Void) {
        let endpoint = endpointForMyCollections()

        dataLoader.loadData(from: endpoint) { result in
            do {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let myCollections = try decoder.decode([CustomCollection].self, from: data)
                    completion(.success(myCollections))
                case .failure(let error):
                    completion(.failure(error))
                }
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
