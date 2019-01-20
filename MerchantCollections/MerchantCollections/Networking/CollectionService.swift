//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


class CollectionService {
    private let dataLoader: DataLoader


    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }


    // MARK: API

    func loadMyCollections(completion: @escaping (Result<[CustomCollection]>) -> Void) {
        let endpoint = RequestFactory.myCollections()

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
}
