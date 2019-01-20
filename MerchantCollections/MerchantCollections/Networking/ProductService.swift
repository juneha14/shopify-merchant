//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


class ProductService {
    private let dataLoader: DataLoader

    
    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }


    // MARK: API

    func loadProducts(withProductQuery query: String, completion: @escaping (Result<[Product]>) -> Void) {
        let endpoint = RequestFactory.products(forProductQuery: query)

        dataLoader.loadData(from: endpoint) { result in
            do {
                let productsContainer = try result.decoded() as Product.Container
                let products = productsContainer.products
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
