//
//  PocketBase.swift
//  GourmetGuesser
//
//  Created by Simon Zwicker on 16.07.24.
//

struct PocketBase<T: Codable>: Codable {
    let page: Int
    let perPage: Int
    let totalPages: Int
    let totalItems: Int
    let items: [T]
}
