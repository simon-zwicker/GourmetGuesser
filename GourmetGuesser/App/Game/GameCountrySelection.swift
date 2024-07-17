//
//  GameCountrySelection.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 17.07.24.
//

import SwiftUI

struct GameCountrySelection: View {

    @Binding var game: GameUtils
    @AppStorage("gameHardMode") var hardMode: Bool = false

    var body: some View {
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
                    if game.selected.isNil {
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
