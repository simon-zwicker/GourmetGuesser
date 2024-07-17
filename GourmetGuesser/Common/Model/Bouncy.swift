//
//  BouncyView.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import SwiftUI

struct Bouncy {
    var ingredient: Ingredient
    var position = CGPoint(x: Int.random(in: 0...200), y: Int.random(in: 0...200))
    var velocity = CGSize(width: Int.random(in: 2...5), height: Int.random(in: 2...5))
    var timer: Timer? = nil
}
