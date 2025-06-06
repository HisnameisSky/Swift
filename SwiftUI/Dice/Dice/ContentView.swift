//
//  ContentView.swift
//  Dice
//
//  Created by 澄界 on 2025/05/21.
//

import SwiftUI

//サイコロを振るアプリ

struct ContentView: View {
    @State private var randomNumber = 1
    @State private var timer: Timer?
    @State private var isRolling = false
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "die.face.\(randomNumber)")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/2)
                .padding()
            Spacer()
            Button {
                playDice()
            } label: {
                Text("ダイスを振ってみる♪")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isRolling)
            Spacer()
        }
        .padding()
    }
    
    private func playDice() {
        print("ボタンが押されたね♬")
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            randomNumber = Int.random(in: 1...6)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            timer?.invalidate()
            timer = nil
            isRolling = false
        }
    }
}

#Preview {
    ContentView()
}
