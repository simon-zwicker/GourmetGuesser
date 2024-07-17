//
//  CalDisplay.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import Foundation
import SwiftUI

struct CalDisplay: View {
    
    @State var ingredients: [Ingredient]
    
    var body: some View {
        List {
            ForEach(ingredients) { ingredient in
                CalRow(ingredient: ingredient)
            }
        }
    }
}

#Preview {
    CalDisplay(ingredients: [
    Ingredient(id: "a", name: "Pommes", image: "", barcode: 8710438094213),
    Ingredient(id: "b", name: "Lauch", image: "", barcode: 4313705999804),
    Ingredient(id: "c", name: "Miesmuschel", image: "", barcode: 20102197),
    Ingredient(id: "d", name: "Joghurt", image: "", barcode: 4061458028813),
    Ingredient(id: "e", name: "Hähnchenschenkel", image: "", barcode: 4061458010641)
    ])
}
