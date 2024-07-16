//
//  GuessView.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import SwiftUI

struct GuessView: View{
    @State var ingredients: [String] = ["Lauch", "Kohl", "Toastbrot", "Cannabis", "Super95", "Distickstoffmonoxid"]
    
    var body: some View {
        List {
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
    }
}

#Preview {
    GuessView()
}
