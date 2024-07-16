//
//  FoodGameAPI.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Mammut

// MARK: - API Endpoint
enum FoodGameAPI {
    case gourmet
    case ingredients
}

// MARK: - API Definitions
extension FoodGameAPI: Endpoint {

    // MARK: - Path
    var path: String {
        switch self {
        case .gourmet: "/gourmet/records"
        case .ingredients: "/ingredients/records"
        }
    }

    // MARK: - Method
    var method: MammutMethod {
        .get
    }

    // MARK: - Headers
    var headers: [MammutHeader] {
        .init()
    }

    // MARK: - Parameters
    var parameters: [String : Any] {
        var parameters: [String: Any] = [:]
        switch self {
        case .ingredients:
            parameters["perPage"] = "100"
            return parameters

        default:
            return parameters
        }
    }

    // MARK: - Encoding
    var encoding: Encoding {
        .url
    }
}
