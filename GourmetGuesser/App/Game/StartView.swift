//
//  StartView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct StartView: View {

    @Binding var game: GameUtils
    @AppStorage("gameHardMode") var hardMode: Bool = false
    @State var showHighscore: Bool = false
    private var notStartable: Bool {
        game.playerName.isEmpty
    }

    var body: some View {
        VStack(spacing: 30.0) {
            Image("appLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150.0)

            VStack() {
                Text("Starte dein Spiel")
                    .font(.Bold.title3)
                Text("Gebe deinen Spielernamen ein und los geht es!")
                    .font(.Regular.regular)

                TextField("Spielername", text: $game.playerName)
                    .font(.Bold.title)
                    .multilineTextAlignment(.center)
                    .padding(15.0)
                    .foregroundStyle(.accent)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.accent, lineWidth: 2.0)
                    )
                    .tint(.accent)
                    .frame(maxWidth: .infinity)
                    .padding(20.0)

                VStack(spacing: 0) {
                    Toggle(isOn: $hardMode, label: {
                        Text("Hardmode")
                            .font(.Bold.regular)
                    })
                    .tint(.accent)

                    Text("Im Hardmode gibt es keine Bezeichnung für Länder oder Zutaten")
                        .font(.Regular.small)
                        .foregroundStyle(.gray)
                        .padding(.top, 15.0)
                }
                .frame(width: 250)
            }

            Text("\(hardMode ? "☠️ Starten ☠️":"Starten")")
                .font(.Bold.regular)
                .padding(.horizontal, 30.0)
                .padding(.vertical, 15.0)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(notStartable ? .gray.opacity(0.5): hardMode ? .red: .accent)
                )
                .disabled(notStartable)
                .contentTransition(.interpolate)
                .button {
                    game.startGame()
                }

            Text("🏅 Highscore anzeigen")
                .font(.Bold.regular)
                .padding(.horizontal, 30.0)
                .padding(.vertical, 15.0)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.accent)
                )
                .button {
                    showHighscore.setTrue()
                }
        }
        .padding()
        .sheet(isPresented: $showHighscore, content: {
            HighscoreScreen()
        })
    }
}
