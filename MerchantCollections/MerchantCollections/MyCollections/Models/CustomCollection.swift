//  Copyright © 2019 June Ha. All rights reserved.

import Foundation


struct CustomCollection: Codable {
    let id: UInt64
    let handle: String
    let title: String
    let bodyHtml: String
    let image: Image
}

extension CustomCollection {
    struct Container: Codable {
        let customCollections: [CustomCollection]
    }
}


struct Image: Codable {
    let src: String
}


struct Collect: Codable {
    let id: UInt64
    let collectionId: UInt64
    let productId: UInt64
}

extension Collect {
    struct Container: Codable {
        let collects: [Collect]
    }
}


struct Product: Codable {
    let id: UInt64
    let title: String
    let bodyHtml: String
    let variants: [Variant]
    let image: Image
}

extension Product {
    struct Container: Codable {
        let products: [Product]
    }
}


struct Variant: Codable {
    let id: UInt64
    let productId: UInt64
    let inventoryQuantity: Int
}
