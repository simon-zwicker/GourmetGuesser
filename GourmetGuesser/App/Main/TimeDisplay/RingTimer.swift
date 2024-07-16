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
        //secondsRemaining get divided by 30, 30 is hardcoded in RingView
        RingView(secondsRemaining: secondsRemaining)
            .onAppear(){
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    secondsRemaining -= 1
                    if secondsRemaining == 0 {
                        timer.invalidate()
                    }
                }
            }
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
