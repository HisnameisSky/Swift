//
//  DiveView.swift
//  Dice
//
//  Created by 澄界 on 2025/07/31.
//

import SwiftUI

//[.](:.)
struct DiceView: View {
    
    @Binding var isShowingRollDiceView: Bool
    @Binding var newNumber: Int?
    @State private var rollCount = UserDefaults.standard.integer(forKey: "RollCount")
    @State private var totalNumber = UserDefaults.standard.integer(forKey: "TotalNumber")
    
    var body: some View {
        VStack {
            //更新される判定の表示
            Text("Total: \(totalNumber) / Roll Count: \(rollCount)")
                .font(.title)
            Spacer()
            //中央に表示するボタン
            Button(action: {
                rollDice()
            }, label: {
                //更新される判定の設定
                Text(newNumber == nil ? "?" : String(newNumber!))
                    .font(.largeTitle)
                    .padding(50)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            })
            //押した際の機能
            .sensoryFeedback(.impact, trigger: newNumber)
            Spacer()
        }
    }
    //サイコロを投げる
    func rollDice() {
        //６までの任意の数字を選んで計算する仕組み
        newNumber = Int.random(in: 1...6)
        rollCount += 1
        UserDefaults.standard.set(rollCount, forKey: "RollCount")
        totalNumber += newNumber!
        UserDefaults.standard.set(totalNumber, forKey: "TotalNumber")
    }
}

#Preview {
    DiceView(isShowingRollDiceView: .constant(true), newNumber: .constant(6))
}
