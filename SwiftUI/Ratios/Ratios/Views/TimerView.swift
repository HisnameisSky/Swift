//
//  TimerView.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import SwiftUI
import Combine

//タイマー状態の定義
private enum TimerState {
    case running
    case paused
}

//[]({:.})
struct TimerView: View {
    
    @State var buttonText: String = "Start"
    @State var timerText: String = "00:00"
    @State private var timerState: TimerState = .paused
    @State private var secondsPassed = 0
    
    private let viewModel = TimerViewModel()
    
    
    var body: some View {
        
        VStack {
            Text(timerText)
                .font(.system(size: 64))
                .frame(width: CGFloat(300), height: CGFloat(52))
                .onReceive(viewModel.timer) { date in
                    self.secondsPassed += 1
                    
                    let hours = String(format: "%02d", self.secondsPassed / 60)
                    let minutes = String(format :"%02d", self.secondsPassed % 60)
                    self.timerText = "\(hours):\(minutes)"
                }
            
            Spacer()
                .frame(height: 20)
            
            Button(action: handleButtonPress) {
                Text(buttonText)
                    .font(.system(size: 20))
                    .fixedSize()
                    .frame(width: CGFloat(200), height: CGFloat(52))
                    .background(Color("Primary"))
                    .cornerRadius(CGFloat(10))
                    .foregroundColor(Color("AltText"))
            }
            Spacer()
            
            Button(action: {
                self.timerState = .paused
                self.viewModel.stop()
                self.buttonText = "Start"
                self.secondsPassed = 0
                self.timerText = "00:00"
            }) {
                Text("Reset")
                    .font(.system(size: 17))
                    .fixedSize()
                    .foregroundColor(Color("Primary"))
            }
        }
    }
    
    private func handleButtonPress() {
        switch timerState {
        case .paused:
            timerState = .running
            viewModel.start()
            buttonText = "Pause"
        case .running:
            timerState = .paused
            viewModel.stop()
            buttonText = "Start"
        }
    }
}
