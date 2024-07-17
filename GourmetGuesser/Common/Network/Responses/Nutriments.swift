//
//  Nutriments.swift
//  CaloBuddy
//
//  Created by Simon Zwicker on 23.06.24.
//

struct Nutriments: Codable {
    let carbohydrates: Double?
    let energyKcal: Int?
    let fat: Double?
    let proteins: Double?

    enum CodingKeys: String, CodingKey {
        case carbohydrates = "carbohydrates_100g"
        case energyKcal = "energy-kcal_100g"
        case fat = "fat_100g"
        case proteins = "proteins_100g"
    }
}
