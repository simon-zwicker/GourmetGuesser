//
//  Product.swift
//  CaloBuddy
//
//  Created by Simon Zwicker on 23.06.24.
//

import SwiftUI

struct Product: Codable, Identifiable {
    let id: UUID = UUID()
    let brands: String
    let code: String
    let imageString: String?
    let nutriments: Nutriments
    let name: String
    let nameDE: String

    enum CodingKeys: String, CodingKey {
        case brands
        case code
        case imageString = "image_url"
        case nutriments
        case name = "product_name"
        case nameDE = "product_name_de"
    }
}

extension String {
    var product: Product? {
        get async throws {
            do {
                let item = try await Network.request(Scanned.self, environment: .openFood, endpoint: OpenFoodAPI.barcode(self))
                if let product = item.product {
                    return product
                }
                throw ProductError.notFound
            } catch {
                throw ProductError.notFound
            }
        }
    }
}

enum ProductError: Error {
    case notFound
}
