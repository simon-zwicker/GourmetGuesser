//
//  DishesList.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 17.07.24.
//

import SwiftUI

struct DishesNavigation: View {
    @Environment(AppUtils.self) var utils
    @State var gourmet = [Gourmet]()
    @Binding var gameUtils: GameUtils
    
    var body: some View {

        NavigationStack(path: $gourmet) {
            List {
                ForEach(Array(gameUtils.gourmetsRound.values), id: \.self) { gourmet in
                    NavigationLink("\(gourmet.food) - \(Country(rawValue: gourmet.country)?.flag ?? "-")", value: gourmet)
                }
            }
            .navigationDestination(for: Gourmet.self) { selection in
                Section(header: Text(selection.food)) {
                    HStack {
                        Text("Zutat")
                        Spacer()
                        Text("kcal/100g")
                    }
                    .padding(.horizontal, 20)
                    CalDisplay(ingredients: utils.ingredients.compactMap({
                        if selection.ingredients.contains($0.id) { return $0 }
                        return nil
                    }))
                }
                .navigationTitle(Country(rawValue: selection.country)?.name ?? "-")
            }
        }
    }
}
