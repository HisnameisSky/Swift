//
//  ContentView.swift
//  Dice
//
//  Created by 澄界 on 2025/07/31.
//

import SwiftUI

//[.](:.)
struct ContentView: View {
    
    @State private var maxNumber: Int = 6
    @State private var newNumber: Int? = nil
    @State private var isShowingRollDiceView = false
    
    var body: some View {
        //条件に応じる画面の表示
        if isShowingRollDiceView {
            DiceView(isShowingRollDiceView: $isShowingRollDiceView, newNumber: $newNumber)
        } else {
            SetDiceMaxView(isShowingRollDiceView: $isShowingRollDiceView, maxNumber: $maxNumber)
        }
    }
}

#Preview {
    ContentView()
}
