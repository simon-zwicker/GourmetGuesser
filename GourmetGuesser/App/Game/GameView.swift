//
//  GameView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct GameView: View {

    @Binding var game: GameUtils
    @AppStorage("gameHardMode") var hardMode: Bool = false
    @State private var timeRemaining = 3
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20.0) {
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

            if timeRemaining > 0 {
                VStack(spacing: 20.0) {
                    Text("\(timeRemaining)")
                        .font(.Bold.large)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText(value: timeRemaining.double))
                        .background(
                            Circle()
                                .fill(.accent)
                                .frame(width: 80, height: 80)
                        )

                    Text("Get ready!")
                }
            } else {
                VStack {
                    if game.selected.isNil {
                        BouncingView(bouncy: game.bouncy)
                            .opacity(game.selected.isNil ? 1.0: 0.0)
                            .animation(.easeInOut, value: game.selected)
                    } else if let currentGourment = game.currentGourmet, let country = Country(rawValue: currentGourment.country) {
                        VStack(spacing: 10) {
                            Text(currentGourment.food)
                                .font(.Bold.large)
                            Text("\(country.flag) \(country.name)")
                                .font(.Bold.title3)

                            Spacer()

                            if game.currentRound < 4 {
                                Text("Nächste Runde")
                                    .font(.Bold.regular)
                                    .padding(.horizontal, 30.0)
                                    .padding(.vertical, 15.0)
                                    .foregroundStyle(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .fill(.accent)
                                    )
                                    .button {
                                        nextRound()
                                    }
                            } else  if game.currentRound == 4 {
                                VStack(spacing: 5.0) {
                                    Text("Du hast")
                                        .font(.Regular.title3)
                                    Text("\(game.gamePoints)")
                                        .font(.Bold.title5)
                                    Text("Punkte erreicht")
                                        .font(.Regular.title3)

                                    VStack {
                                        Text("🏆 Score eintragen")
                                            .font(.Bold.regular)
                                            .padding(.horizontal, 30.0)
                                            .padding(.vertical, 15.0)
                                            .foregroundStyle(.white)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10.0)
                                                    .fill(.accent)
                                            )
                                            .button {

                                            }

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

                                            }

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
                                                newGame()
                                            }
                                    }
                                    .padding(.top, 30.0)
                                }
                            }
                        }
                    }

                    Spacer()

                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 100.0)),
                        GridItem(.flexible(minimum: 100.0))
                    ], 
                    spacing: 10.0,
                    content: {
                        ForEach(game.currentCountries, id: \.self) { country in
                            HStack {
                                Spacer()

                                VStack {
                                    Text(country.flag)
                                        .font(.Regular.extraLarge)

                                    if !hardMode {
                                        Text(country.name)
                                            .font(.Bold.regular)
                                            .foregroundStyle(.black)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    }
                                }

                                Spacer()
                            }
                            .padding(30.0)
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke(.gray, lineWidth: 2.0)
                                    .if(country == game.selected, { view in
                                        view.fill(game.selectedCorrectCountry ? .green: .red)
                                    })
                            )
                            .button {
                                if game.selected.isNil, game.remainingTime > 0 {
                                    game.selected = country
                                    game.addPoints()
                                    if hardMode {
                                        game.hardModeExtra()
                                    }
                                }
                            }
                        }
                    })
                }
            }
        }
        .padding()
        .onReceive(timer, perform: { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
            }
        })
    }

    private func nextRound() {
        self.timeRemaining = 3
        self.timer = self.timer.upstream.autoconnect()
        game.nextRound()
    }

    private func newGame() {
        game.startGame()
        self.timeRemaining = 3
        self.timer = self.timer.upstream.autoconnect()
    }
}
