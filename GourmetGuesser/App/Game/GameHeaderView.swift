//
//  GameHeaderView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 17.07.24.
//

import SwiftUI

struct GameHeaderView: View {

    @Binding var game: GameUtils
    @Binding var timeRemaining: Int

    var body: some View {
        HStack {
            if timeRemaining < 1 {
                VStack {
                    Text("Punkte")
                        .font(.Regular.small)

                    Text("\(game.gamePoints)")
                        .font(.Bold.title3)
                }
                .frame(width: 100)
            }

            Text("Runde \(game.currentRound + 1)/\(game.maxRounds)")
                .font(.Bold.heading1)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 50.0)
        .animation(.easeInOut, value: timeRemaining)
    }
}
