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

    @Environment(AppUtils.self) var utils
    var product: Product?

    var body: some View {
        HStack {
            if let ingredient = utils.ingredientsByCode(product?.code) {
                Text(ingredient.name)
            }
            Spacer()
            if let kcal100g = product?.nutriments.energyKcal {
                Text("\(kcal100g)")
            } else {
                Text("-")
            }
        }
    }
}

