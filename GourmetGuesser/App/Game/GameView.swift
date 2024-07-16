//
//  GameView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct GameView: View {

    @Binding var game: GameUtils
    @State private var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20.0) {
            Text("Runde \(game.currentRound + 1)")
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
                    BouncingView()

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

                                    if !game.hardMode {
                                        Text(country.name)
                                            .font(.Bold.small)
                                    }
                                }

                                Spacer()
                            }
                            .padding(30.0)
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke(.gray, lineWidth: 2.0)
                            )
                            .button {
                                game.selected = country
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
}
