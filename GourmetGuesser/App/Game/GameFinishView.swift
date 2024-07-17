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
    @State var showHighscore: Bool = false
    @State var showDishes: Bool = false
    @State var scoreSaved: Bool = false
    var buttonNew: () -> Void
    var buttonScore: () -> Void

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
                    VStack(spacing: 3.0) {
                        Text("🧾")
                        Text("Gerichte ansehen")
                            .font(.Bold.regular)
                    }
                    .padding(.vertical, 10.0)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.accent)
                    )
                    .button {
                        showDishes.setTrue()
                    }

                    VStack(spacing: 3.0) {
                        Text("🕹️")
                        Text("Neues Spiel")
                            .font(.Bold.regular)
                    }
                    .padding(.vertical, 10.0)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.accent)
                    )
                    .button {
                        buttonNew()
                    }
                }

                ZStack {
                    VStack(spacing: 3.0) {
                        Text("🏅")
                        Text("Highscore ansehen")
                            .font(.Bold.regular)
                    }
                    .opacity(highscoreAdding ? 0.0: 1.0)

                    ProgressView()
                        .opacity(highscoreAdding ? 1.0: 0.0)
                }
                .padding(.vertical, 10.0)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.accent)
                )
                .disabled(highscoreAdding)
                .button {
                    showHighscore.setTrue()
                }

                VStack(spacing: 3.0) {
                    Text("Zum Startbildschirm")
                        .font(.Bold.regular)
                }
                .padding(.vertical, 10.0)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.accent)
                )
                .button {
                    game.backToHome()
                }

            }
            .padding(.top, 30.0)
            .onAppear {
                if !scoreSaved {
                    buttonScore()
                    scoreSaved.setTrue()
                }
            }
        }
        .sheet(isPresented: $showHighscore, content: {
            HighscoreScreen()
        })
        .sheet(isPresented: $showDishes, content: {
            DishesNavigation(gameUtils: $game)
        })
        .interactiveDismissDisabled()
    }
}
