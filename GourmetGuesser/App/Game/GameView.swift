//
//  GameView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct GameView: View {

    @Environment(AppUtils.self) var utils
    @Binding var game: GameUtils
    @State private var timeRemaining = 3
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var highscoreAdding: Bool = false
    @State var showHighscore: Bool = false

    var body: some View {
        VStack(spacing: 20.0) {

            GameHeaderView(game: $game, timeRemaining: $timeRemaining)

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
                                GameFinishView(game: $game, highscoreAdding: $highscoreAdding) {
                                    newGame()
                                } buttonScore: {
                                    if !highscoreAdding {
                                        Task {
                                            await addToHighscore()
                                        }
                                    }
                                } buttonShow: {
                                    
                                } buttonHighscore: {
                                    showHighscore.setTrue()
                                }

                            }
                        }
                    }

                    Spacer()

                    GameCountrySelection(game: $game)
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
        .sheet(isPresented: $showHighscore, content: {
            ZStack {
                Color.clear.ignoresSafeArea()
                    .background(.mainBackground.gradient)

                List {
                    ForEach(utils.scores.sorted(by: { $0.points > $1.points }), id: \.id) { score in
                        HStack {
                            Text(score.name)
                                .font(.Bold.regular)
                            Spacer()
                            Text("\(score.points)")
                                .font(.Bold.title4)
                                .foregroundStyle(.accent)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .padding(.top, 40.0)
            }
            .onAppear {
                Task {
                    await utils.updateScore()
                }
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
        self.highscoreAdding.setFalse()
        self.timeRemaining = 3
        self.timer = self.timer.upstream.autoconnect()
    }

    private func addToHighscore() async {
        self.highscoreAdding.setTrue()
        do {
            let _ = try await Network.request(
                Score.self,
                environment: .foodGame,
                endpoint: FoodGameAPI.addHighscore(game.playerName, game.gamePoints)
            )
            self.highscoreAdding.setFalse()
        } catch {
            print("Error on adding Highscore: \(error.localizedDescription)")
        }
    }
}
