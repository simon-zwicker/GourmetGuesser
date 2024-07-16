//
//  Network.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Foundation
import Mammut

struct Network {

    static private var openFoodAPI: Mammut {
        Mammut(components: NetworkEnv.openFood.components, loglevel: .debug)
    }

    static private var foodGameAPI: Mammut {
        Mammut(components: NetworkEnv.foodGame.components, loglevel: .debug)
    }

    static func request<T: Codable>(
        _ T: T.Type,
        environment: NetworkEnv,
        endpoint: Endpoint
    ) async throws -> T {
        let result = await req(T.self, endpoint, environment )
        switch result {
        case .success(let success): return success
        case .failure(let failure): throw failure.self
        }
    }

    static private func req<T: Codable>(
        _ T: T.Type,
        _ endpoint: Endpoint,
        _ env: NetworkEnv
    ) async -> Result<T, Error> {
        switch env {
        case .openFood:
            return await openFoodAPI.request(endpoint, error: ErrorObj.self)
        case .foodGame:
            return await foodGameAPI.request(endpoint, error: ErrorObj.self)
        }
    }
}
