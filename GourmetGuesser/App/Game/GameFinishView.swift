//
//  GameFinishView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 17.07.24.
//

import SwiftUI

struct GameFinishView: View {

    @Binding var game: GameUtils
    var buttonNew: () -> Void
    var buttonScore: () -> Void
    var buttonShow: () -> Void

    var body: some View {
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
                        buttonScore()
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
                        buttonScore()
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
                        buttonNew()
                    }
            }
            .padding(.top, 30.0)
        }
    }
}
