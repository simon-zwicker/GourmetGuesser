//
//  AppUtils.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Foundation

@Observable
class AppUtils {

    // MARK: - Properties
    private(set) var gourmets: [Gourmet] = .init()
    private(set) var ingredients: [Ingredient] = .init()
    private(set) var countries: [Country] = .init()
    private(set) var scores: [Score] = .init()
    private(set) var isLoading: Bool = true


    // MARK: - FetchData
    func fetch() async {
        isLoading.setTrue()
        do {
            self.ingredients = try await fetchIngredients()
            self.gourmets = try await fetchGourmets()
            self.scores = try await fetchScores()
            self.convertCountries()
            self.isLoading.setFalse()
        } catch {
            print("Error on fetching Data: \(error.localizedDescription)")
        }
    }

    private func fetchGourmets() async throws -> [Gourmet] {
        let data = try await Network.request(
            PocketBase<Gourmet>.self,
            environment: .foodGame,
            endpoint: FoodGameAPI.gourmet
        )
        return data.items
    }

    private func fetchIngredients() async throws -> [Ingredient] {
        let data = try await Network.request(
            PocketBase<Ingredient>.self,
            environment: .foodGame,
            endpoint: FoodGameAPI.ingredients
        )
        return data.items
    }

    private func fetchScores() async throws -> [Score] {
        let data = try await Network.request(
            PocketBase<Score>.self,
            environment: .foodGame,
            endpoint: FoodGameAPI.highscore
        )
        return data.items
    }

    private func convertCountries() {
        self.countries = .init()
        for gourmet in gourmets {
            guard let country = Country(rawValue: gourmet.country) else { continue }
            self.countries.append(country)
        }
    }
}
