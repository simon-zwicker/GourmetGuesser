//
//  GameScreen.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct GameScreen: View {

    // MARK: - Properties
    @Environment(AppUtils.self) private var utils
    @State var game: GameUtils = .init()

    var body: some View {
        ZStack {
            if game.gameIsRunning {
                GameView(game: $game)
            } else {
                StartView(game: $game)
            }
        }
        .onAppear {
            game.setup(utils.gourmets, utils.ingredients, utils.countries)
        }
    }
}
