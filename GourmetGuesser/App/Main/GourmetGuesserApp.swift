//
//  GourmetGuesserApp.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI

@main
struct GourmetGuesserApp: App {

    // MARK: - States
    @State private var utils: AppUtils = .init()

    var body: some Scene {
        WindowGroup {
            ZStack {
                if utils.isLoading {
                    LoadingScreen()
                } else {
                    MainScreen()
                        .environment(utils)
                }
            }
            .onAppear {
                Task {
                    await utils.fetch()
                }
            }
        }
    }
}
