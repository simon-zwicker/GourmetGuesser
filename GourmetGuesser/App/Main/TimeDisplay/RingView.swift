//
//  RingTimer.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import SwiftUI
import SwiftChameleon

struct RingView: View {

    private static let ShadowColor: Color = Color.black.opacity(0.2)
    private static let ShadowRadius: CGFloat = 5
    private static let ShadowOffsetMultiplier: CGFloat = ShadowRadius + 2

    private let ringWidth: CGFloat = 5
    private let percent: Double
    private let secondsRemaining: Double
    private let backgroundColor: Color = .mainBackground
    private let foregroundColors: [Color] = [.timerForeground]
    private let startAngle: Double = -90
    private var gradientStartAngle: Double {
        self.percent >= 100 ? relativePercentageAngle - 360 : startAngle
    }
    private var absolutePercentageAngle: Double {
        RingShape.percentToAngle(percent: self.percent, startAngle: 0)
    }
    private var relativePercentageAngle: Double {
        // Take into account the startAngle
        absolutePercentageAngle + startAngle
    }
    private var firstGradientColor: Color {
        self.foregroundColors.first ?? .black
    }
    private var lastGradientColor: Color {
        self.foregroundColors.last ?? .black
    }
    private var ringGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: self.foregroundColors),
            center: .center,
            startAngle: Angle(degrees: self.gradientStartAngle),
            endAngle: Angle(degrees: relativePercentageAngle)
        )
    }

    init(secondsRemaining: Double) {
        self.secondsRemaining = secondsRemaining
        self.percent = { (secondsRemaining / 30) * 100 } ()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background for the ring
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth))
                    .fill(self.backgroundColor)
                // Foreground
                RingShape(percent: self.percent, startAngle: self.startAngle)
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap: .round))
                    .fill(self.ringGradient)
                // End of ring with drop shadow
                if self.getShowShadow(frame: geometry.size) {
                    Circle()
                        .fill(self.lastGradientColor)
                        .frame(
                            width: self.ringWidth,
                            height: self.ringWidth,
                            alignment: .center
                        )
                        .offset(
                            x: self.getEndCircleLocation(frame: geometry.size).0,
                            y: self.getEndCircleLocation(frame: geometry.size).1
                        )
                        .shadow(
                            color: RingView.ShadowColor,
                            radius: RingView.ShadowRadius,
                            x: self.getEndCircleShadowOffset().0,
                            y: self.getEndCircleShadowOffset().1
                        )
                }
                Text("\(secondsRemaining.int)")
                    .bold()
            }
        }
        // Padding to ensure that the entire ring fits within the view size allocated
        .padding(self.ringWidth / 2)
        .frame(width: 50)
    }

    private func getEndCircleLocation(frame: CGSize) -> (CGFloat, CGFloat) {
        // Get angle of the end circle with respect to the start angle
        let angleOfEndInRadians: Double = relativePercentageAngle.radians
        let offsetRadius = min(frame.width, frame.height) / 2
        return (offsetRadius * cos(angleOfEndInRadians).cgFloat, offsetRadius * sin(angleOfEndInRadians).cgFloat)
    }

    private func getEndCircleShadowOffset() -> (CGFloat, CGFloat) {
        let angleForOffset = absolutePercentageAngle + (self.startAngle + 90)
        let angleForOffsetInRadians = angleForOffset.radians
        let relativeXOffset = cos(angleForOffsetInRadians)
        let relativeYOffset = sin(angleForOffsetInRadians)
        let xOffset = relativeXOffset.cgFloat * RingView.ShadowOffsetMultiplier
        let yOffset = relativeYOffset.cgFloat * RingView.ShadowOffsetMultiplier
        return (xOffset, yOffset)
    }

    private func getShowShadow(frame: CGSize) -> Bool {
        let circleRadius = min(frame.width, frame.height) / 2
        let remainingAngleInRadians = (360 - absolutePercentageAngle).radians.cgFloat
        if self.percent >= 100 {
            return true
        } else if circleRadius * remainingAngleInRadians <= self.ringWidth {
            return true
        }
        return false
    }
}


