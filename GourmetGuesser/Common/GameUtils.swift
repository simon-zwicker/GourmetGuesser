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
    var hardMode: Bool = false

    // MARK: - RoundData
    let maxRounds: Int = 5
    private(set) var currentRound: Int = 0
    
    var currentCountries: [Country] {
        countryRound[currentRound] ?? []
    }

    var currentGourmet: Gourmet? {
        gourmetsRound[currentRound]
    }

    private var gourmetsRound: [Int: Gourmet] = [:]
    private(set) var gameIsRunning: Bool = false
    private(set) var countryRound: [Int: [Country]] = [:]
    var selected: Country?

    // MARK: - AllData
    private var allGourmets: [Gourmet] = .init()
    private var allIngredients: [Ingredient] = .init()
    private var allCountries: [Country] = .init()

    func startGame() {
        currentRound = 0
        self.gourmetsRound = [:]

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
}
