//
//  RingTimer.swift
//  GourmetGuesser
//
//  Created by Mia Koring on 16.07.24.
//

import SwiftUI

struct RingTimer: View {
    @Binding var timer: Timer?
    @Binding var secondsRemaining: Double
    var body: some View {
        RingView(secondsRemaining: secondsRemaining)
    }
}

struct RingTimerPreview: View {
    @State var timer: Timer? = nil
    @State var secondsRemaining: Double = 30
    var body: some View {
        RingTimer(timer: $timer, secondsRemaining: $secondsRemaining)
    }
}

#Preview {
   RingTimerPreview()
}
