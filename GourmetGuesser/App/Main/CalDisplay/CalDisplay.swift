//
//  CalDisplay.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import Foundation
import SwiftUI

struct CalDisplay: View {
    
    @Environment(AppUtils.self) var utils
    @State var ingredients: [Ingredient] = []
    @State var scanned: [Product] = []
    @Binding var showLoading: Bool
    let dish: Gourmet

    var body: some View {
        VStack {
            List {
                ForEach(scanned, id: \.id) { scan in
                    CalRow(product: scan)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
        }
        .onAppear {
            showLoading.setTrue()
            ingredients = utils.getIngredients(dish)
            Task {
                await fetchAll()
            }
        }
    }

    private func fetchAll() async {
        scanned.removeAll()
        for ingredient in ingredients {
            print("Call \(ingredient.barcode)")
            guard let product = try? await ingredient.barcode.description.product else {
                scanned.append(
                    Product(
                        brands: nil,
                        code: ingredient.barcode.description,
                        imageString: nil,
                        nutriments: nil,
                        name: ingredient.name,
                        nameDE: nil
                    )
                )
                continue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                scanned.append(product)
            }
        }

        self.showLoading.setFalse()
    }
}
