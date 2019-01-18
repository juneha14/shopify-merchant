//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


class DataLoader {
    func loadData(from endpoint: Endpoint, completion: @escaping (Result<Data>) -> Void) {
        guard let url = endpoint.url else {
            return completion(.failure(Endpoint.URLError.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                completion(.success(data ?? Data()))
            }
        }

        task.resume()
    }
}
