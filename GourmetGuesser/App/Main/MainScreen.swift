//
//  ContentView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI
import SwiftChameleon

struct MainScreen: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.ignoresSafeArea()
                    .background(
                        LinearGradient(
                            colors: [
                                .accentColor,
                                .mainBackground,
                                .mainBackground.opacity(0.66),
                                .mainBackground.opacity(0.44)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                //GameScreen()
            }
        }
    }
}

#Preview {
    MainScreen()
}
