//
//  HighscoreScreen.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 17.07.24.
//

import SwiftUI

struct HighscoreScreen: View {

    @Environment(AppUtils.self) var utils

    var body: some View {
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
    }
}

#Preview {
    HighscoreScreen()
}
