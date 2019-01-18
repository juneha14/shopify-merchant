//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


class DataLoader {
    enum Result {
        case success(Data)
        case failure(Error)
    }

    func loadData(from endpoint: Endpoint, completion: @escaping (Result) -> Void) {
        guard let url = endpoint.url else {
            return completion(.failure(Endpoint.URLError.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(error))
            }

            completion(.success(data ?? Data()))
        }

        task.resume()
    }
}
