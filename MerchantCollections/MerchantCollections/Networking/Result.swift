//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


enum Result<Value> {
    case success(Value)
    case failure(Error)
}

private extension Result {
    func extract() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

extension Result where Value == Data {
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = try extract()
        return try decoder.decode(T.self, from: data)
    }
}
