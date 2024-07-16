//
//  NetworkEnv.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Foundation

enum NetworkEnv {
    case openFood
    case foodGame
}

extension NetworkEnv {
    var scheme: String {
        switch self {
        case .openFood: "https"
        case .foodGame: "https"
        }
    }

    var host: String {
        switch self {
        case .openFood: "world.openfoodfacts.net"
        case .foodGame: "kirreth.pockethost.io"
        }
    }

    var path: String {
        switch self {
        case .openFood: "/api/v2"
        case .foodGame: "/api/collections"
        }
    }

    var components: URLComponents {
        var comp = URLComponents()
        comp.scheme = scheme
        comp.host = host
        comp.path = path
        return comp
    }
}
