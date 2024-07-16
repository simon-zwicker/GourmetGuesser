//
//  Gourmet.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

struct Gourmet: Codable, Hashable {
    let id: String
    let country: String
    let food: String
    let ingredients: [String]
}
