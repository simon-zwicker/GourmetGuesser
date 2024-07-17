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
    @State var scanned: [Product] = []

    var body: some View {
        List {
            ForEach(scanned, id: \.id) { scan in
                CalRow(product: scan)
            }
        }
        .task {
            await fetchAll()
        }
    }

    private func fetchAll() async {
        scanned.removeAll()
        do {
            for ingredient in ingredients {
                let product = try await ingredient.barcode.description.product
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    guard let product else { return }
                    scanned.append(product)
                }
            }

            print("Ingredients: \(ingredients.compactMap({ $0.barcode }))")
            print("Products: \(scanned.compactMap({ $0.code }))")

        } catch {
            print("error")
        }
    }
}

#Preview {
    CalDisplay(ingredients: [
        Ingredient(id: "a", collectionId: "", name: "Pommes", image: "", barcode: 8710438094213),
        Ingredient(id: "b", collectionId: "", name: "Lauch", image: "", barcode: 4313705999804),
        Ingredient(id: "c", collectionId: "", name: "Miesmuschel", image: "", barcode: 20102197),
        Ingredient(id: "d", collectionId: "", name: "Joghurt", image: "", barcode: 4061458028813),
        Ingredient(id: "e", collectionId: "", name: "Hähnchenschenkel", image: "", barcode: 4061458010641)
    ])
}
