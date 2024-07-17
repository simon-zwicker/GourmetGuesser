//
//  Ingredient.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

struct Ingredient: Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    let barcode: Int
}
