//
//  OpenFoodAPI.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Mammut

// MARK: - API Endpoint
enum OpenFoodAPI {
    case barcode(String)
}

// MARK: - API Definitions
extension OpenFoodAPI: Endpoint {

    // MARK: - Path
    var path: String {
        switch self {
        case .barcode(let string): "/product/\(string)"
        }
    }

    // MARK: - Method
    var method: MammutMethod {
        switch self {
        case .barcode: .get
        }
    }

    // MARK: - Headers
    var headers: [MammutHeader] {
        var headers: [MammutHeader] = .init()
        switch self {
        case .barcode: headers.append(.userAgent("GourmetGuesser/1.0 (gourmetguesser@zwicker.io)"))
        }
        return headers
    }

    // MARK: - Parameters
    var parameters: [String : Any] { [:] }

    // MARK: - Encoding
    var encoding: Encoding {
        switch self {
        case .barcode: .url
        }
    }
}
