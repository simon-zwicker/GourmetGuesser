//
//  ContentView.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

import SwiftUI
import SwiftChameleon

struct MainScreen: View {
    @State var game: Game? = nil
    @State var nameInput: String = ""
    @State var showNameEmpty: Bool = false
    
    var body: some View {
        VStack {
            if let game {
                Text("Game")
            }
            else {
                Spacer()
                Text("AppName")
                    .font(.title2)
                Text("Starte ein Spiel")
                    .font(.title3)
                Spacer()
                TextField("Name", text: $nameInput)
                    .lineLimit(1)
                    .textFieldStyle(.roundedBorder)
                Text("Start")
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.green.secondary)
                        
                    }
                Button {
                    if nameInput.isEmpty {
                        showNameEmpty = true
                        return
                    }
                    game = Game(name: nameInput)
                } label: {
                    
                }
                Spacer()
                Spacer()
                .alert("Name darf nicht leer sein", isPresented: $showNameEmpty) {
                    Button {
                        showNameEmpty = false
                    } label: {
                        Text("OK")
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .background(){
            LinearGradient(colors: [.green.opacity(0.8), .green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MainScreen()
}
