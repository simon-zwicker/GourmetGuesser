//
//  LoadingScreen.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

struct LoadingScreen: View {

    @State private var animationAmount: CGFloat = 1

    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
                .background(.mainBackground)

            VStack {
                Image("appLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .scaleEffect(animationAmount)
                    .animation(
                        .linear(duration: 0.8)
                        .delay(0.1)
                        .repeatForever(autoreverses: true),
                        value: animationAmount)
                    .onAppear {
                        animationAmount = 0.5
                    }

                Text("Loading")
                    .font(.Bold.heading1)
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
