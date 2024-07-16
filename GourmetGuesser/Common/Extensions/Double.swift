//
//  Double.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import Foundation

extension Double {
    var radians: Double {
        self * Double.pi / 180
    }

    var cgFloat: CGFloat {
        CGFloat(self)
    }

    func multiply(_ value: Double = 100.0) -> Double {
        self * value
    }
}

