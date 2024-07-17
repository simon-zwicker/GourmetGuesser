//
//  Game.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import Foundation

@Observable
class GameUtils {
    var playerName: String = ""

    // MARK: - RoundData
    let maxRounds: Int = 5
    private(set) var currentRound: Int = 0
    var gamePoints: Int = 0
    private var pointsLastRount: Int = 0
    private var maxTime: Int = 33
    private var roundStartDate: Date = .now
    private var roundEndDate: Date = .now


    var currentCountries: [Country] {
        countryRound[currentRound] ?? []
    }

    var currentGourmet: Gourmet? {
        gourmetsRound[currentRound]
    }

    var selectedCorrectCountry: Bool {
        selected?.rawValue == currentGourmet?.country
    }

    var currentIngredients: [Ingredient] {
        guard let currentGourmet else { return [] }
        var ingredients: [Ingredient] = []
        for ingredient in currentGourmet.ingredients {
            guard let first = allIngredients.first(where: { $0.id == ingredient }) else { continue }
            ingredients.append(first)
        }
        return ingredients
    }

    var bouncy: [Bouncy] {
        currentIngredients.compactMap({ Bouncy(ingredient: $0) })
    }

    private var gourmetsRound: [Int: Gourmet] = [:]
    private(set) var gameIsRunning: Bool = false
    private(set) var countryRound: [Int: [Country]] = [:]
    var selected: Country?

    // MARK: - AllData
    private var allGourmets: [Gourmet] = .init()
    private var allIngredients: [Ingredient] = .init()
    private var allCountries: [Country] = .init()

    func nextRound() {
        currentRound += 1
        selected = nil
        roundStartDate = .now
    }

    func addPoints() {
        roundEndDate = .now
        guard let difference = Calendar.current.dateComponents(
            [.second],
            from: roundStartDate,
            to: roundEndDate
        ).second else { return }

        if selectedCorrectCountry {
            if difference >= maxTime {
                pointsLastRount = 10
            } else {
                pointsLastRount = (maxTime - difference) * 10
            }
            gamePoints += pointsLastRount
        }
    }

    func hardModeExtra() {
        gamePoints += pointsLastRount
    }

    func startGame() {
        currentRound = 0
        self.gourmetsRound = [:]
        self.gamePoints = 0
        self.pointsLastRount = 0
        self.selected = nil
        self.roundStartDate = .now

        let randomGourmets = allGourmets.shuffled().prefix(5)
        for (index, gourmet) in randomGourmets.enumerated() {
            self.gourmetsRound[index] = gourmet

            let gourmetCountry = allCountries.first(where: { $0.rawValue == gourmet.country }) ?? .pol
            let otherCountries = allCountries.filter({ $0 != gourmetCountry })
            var randomCountries = otherCountries.shuffled().prefix(3)
            randomCountries.append(gourmetCountry)
            self.countryRound[index] = randomCountries.shuffled()
        }

        gameIsRunning.setTrue()
    }

    func setup(_ gourmets: [Gourmet], _ ingredients: [Ingredient], _ countries: [Country]) {
        self.allGourmets = gourmets
        self.allIngredients = ingredients
        self.allCountries = countries
    }

    func getIngredients(_ gourmet: Gourmet) -> [Ingredient] {
        var ingredients: [Ingredient] = []
        for ingredient in gourmet.ingredients {
            guard let first = allIngredients.first(where: { $0.id == ingredient }) else { continue }
            ingredients.append(first)
        }
        return ingredients
    }

    func backToHome() {
        self.playerName = ""
        self.gameIsRunning = false
        currentRound = 0
        self.gourmetsRound = [:]
        self.gamePoints = 0
        self.pointsLastRount = 0
        self.selected = nil
        self.roundStartDate = .now
    }
}
