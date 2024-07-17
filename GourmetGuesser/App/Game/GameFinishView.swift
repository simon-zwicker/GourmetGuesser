//
//  GameFinishView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 17.07.24.
//

import SwiftUI

struct GameFinishView: View {

    @Binding var game: GameUtils
    @Binding var highscoreAdding: Bool
    var buttonNew: () -> Void
    var buttonScore: () -> Void
    var buttonShow: () -> Void
    var buttonHighscore: () -> Void
    var buttonDishes: () -> Void

    var body: some View {
        VStack(spacing: 5.0) {
            Text("Du hast")
                .font(.Regular.title3)
            Text("\(game.gamePoints)")
                .font(.Bold.title5)
            Text("Punkte erreicht")
                .font(.Regular.title3)

            VStack {
                HStack {
                    ZStack {
                        Text("🏆 Score speichern")
                            .font(.Bold.regular)
                            .opacity(highscoreAdding ? 0.0: 1.0)

                        ProgressView()
                            .opacity(highscoreAdding ? 1.0: 0.0)
                    }
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 15.0)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.accent)
                    )
                    .button {
                        buttonScore()
                    }
                    .frame(maxWidth: .infinity)

                    Text("🧾 Gerichte ansehen")
                        .font(.Bold.regular)
                        .padding(.horizontal, 30.0)
                        .padding(.vertical, 15.0)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.accent)
                        )
                        .button {
                            buttonDishes()
                        }
                        .frame(maxWidth: .infinity)
                }

                HStack {
                    Text("🕹️ Neues Spiel")
                        .font(.Bold.regular)
                        .padding(.horizontal, 30.0)
                        .padding(.vertical, 15.0)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.accent)
                        )
                        .button {
                            buttonNew()
                        }

                    Text("🏅 Highscore ansehen")
                        .font(.Bold.regular)
                        .padding(.horizontal, 30.0)
                        .padding(.vertical, 15.0)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.accent)
                        )
                        .button {
                            buttonHighscore()
                        }
                }

            }
            .padding(.top, 30.0)
        }
    }
}
