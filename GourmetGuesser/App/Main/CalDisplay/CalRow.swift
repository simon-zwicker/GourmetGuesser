//
//  CalRow.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import Foundation
import SwiftUI
import Mammut

struct CalRow: View {
    let ingredient: Ingredient
    @State var kcal100g: Int? = nil
    
    var body: some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            if let kcal100g {
                Text("\(kcal100g)")
            } else {
                Text("-")
            }
        }
        .onAppear() {
            DispatchQueue.main.async {
                Task {
                    do {
                        kcal100g = try await getCal(barcode: "\(ingredient.barcode)")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func getCal(barcode: String) async throws -> Int? {
        let res = try await Network.request(Scanned.self, environment: .openFood, endpoint: OpenFoodAPI.barcode(barcode))
        
        guard let product = res.product else {
            print("failed")
            return nil
        }
        print("\n Ab\n\nbarcode: \(barcode)\n\n\n\(product)\n\n\n\n\n\n")
        return product.nutriments.energyKcal
    }
}

#Preview {
    List {
        CalRow(ingredient: Ingredient(id: "a", name: "Pommes", image: "", barcode: 8710438094213))
        CalRow(ingredient: Ingredient(id: "e", name: "Hähnchenschenkel", image: "", barcode: 4061458010641))
    }
}

