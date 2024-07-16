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
                    .background(.mainBackground.gradient)

                GameScreen()
            }
        }
    }
}
