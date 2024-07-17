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
            ZStack {
                Color.clear.ignoresSafeArea()
                    .background(.mainBackground.gradient)
                
                List {
                    ForEach(Array(gameUtils.gourmetsRound.values), id: \.self) { gourmet in
                        NavigationLink(value: gourmet) {
                            HStack {
                                Text(gourmet.food)
                                    .font(.Bold.title5)

                                Spacer()

                                Text("\(Country(rawValue: gourmet.country)?.flag ?? "Unknown")")
                                    .font(.Bold.large)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.vertical, 30.0)
                .listStyle(.plain)
                .navigationTitle("Gerichte")
                .navigationDestination(for: Gourmet.self) { selection in
                    DishDetail(dish: selection)
                }
            }
        }
    }
}

struct DishDetail: View {

    let dish: Gourmet
    @State var showLoading: Bool = true

    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
                .background(.mainBackground.gradient)

            VStack(spacing: 20.0) {
                Text(dish.food)
                    .font(.Bold.title3)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Zutat")
                            .font(.Bold.regular)
                        Spacer()
                        Text("kcal/100g")
                            .font(.Bold.regular)
                    }
                    .padding(.horizontal, 20)
                }

                ProgressView()
                    .opacity(showLoading ? 1.0: 0.0)

                CalDisplay(showLoading: $showLoading, dish: dish)
            }
        }
        .navigationTitle(Country(rawValue: dish.country)?.name ?? "-")
    }
}
