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
    case highscore
    case addHighscore(String, Int)
}

// MARK: - API Definitions
extension FoodGameAPI: Endpoint {

    // MARK: - Path
    var path: String {
        switch self {
        case .gourmet: "/gourmet/records"
        case .ingredients: "/ingredients/records"
        case .highscore, .addHighscore: "/highscoreGG/records"
        }
    }

    // MARK: - Method
    var method: MammutMethod {
        switch self {
        case .addHighscore(let string, let int): .post
        default: .get
        }
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

        case .addHighscore(let name, let points):
            parameters["name"] = name
            parameters["points"] = points

        default:
            return parameters
        }
        return parameters
    }

    // MARK: - Encoding
    var encoding: Encoding {
        switch self {
        case .addHighscore(let string, let int):
            .json
        default:
                .url
        }
    }
}
