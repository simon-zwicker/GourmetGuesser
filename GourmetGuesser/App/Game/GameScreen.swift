//
//  GameScreen.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct GameScreen: View {

    // MARK: - Properties
    @State var game: Game = .init()
    private var notStartable: Bool {
        game.playerName.isEmpty
    }

    var body: some View {
        VStack(spacing: 30.0) {
            Image("appLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150.0)

            VStack(alignment: .leading) {
                Text("Starte dein Spiel")
                    .font(.Bold.regular)
                Text("Gebe deinen Spielernamen ein und los geht es!")
                    .font(.Regular.small)

                TextField("Spielername", text: $game.playerName)
                    .textFieldStyle(.roundedBorder)
            }

            Text("Starten")
                .font(.Bold.regular)
                .padding(.horizontal, 30.0)
                .padding(.vertical, 15.0)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(notStartable ? .gray.opacity(0.5): .accent)
                )
                .disabled(notStartable)
        }
        .padding()
    }
}

#Preview {
    GameScreen()
}
