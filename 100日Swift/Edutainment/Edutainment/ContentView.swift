//
//  ContentView.swift
//  Edutainment
//
//  Created by 澄界 on 2025/07/20.
//

import SwiftUI

//はじめにアプリを開き写っていく画面

//Protocol式の構造体
struct ContentView: View {
    //依存される要素・変数
    @State private var currentView = 0
    @State private var numberOfTable = 1
    @State private var numberOfQuestions = 1
    @State private var score = 1
    //表示
    var body: some View {
        //条件に応じてViewが変わる
        if currentView == 0 {
            SettingView(currentView: $currentView, numberOfTable: $numberOfTable, numberOfQuestions: $numberOfQuestions)
        } else if currentView == 1 {
            QuestionView(currentView: $currentView, numberOfQuestion: $numberOfQuestions, numberOfTable: $numberOfTable, score: $score)
        } else {
            ResultView(currentView: $currentView, score: $score)
        
        }
    }
}

#Preview {
    ContentView()
}
