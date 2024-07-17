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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20.0) {
            Text("Runde \(game.currentRound + 1)/\(game.maxRounds)")
                .font(.Bold.heading1)

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
                                .font(.Bold.title3)
                            Text("\(country.flag) \(country.name)")
                                .font(.Bold.regular)

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
                            }
                        }
                    }

                    Spacer()

                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 100.0)),
                        GridItem(.flexible(minimum: 100.0))
                    ], 
                    spacing: 30.0,
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
                                if game.selected.isNil {
                                    game.selected = country
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
            }
        })
    }

    private func nextRound() {
        self.timeRemaining = 3
        game.nextRound()
    }
}
