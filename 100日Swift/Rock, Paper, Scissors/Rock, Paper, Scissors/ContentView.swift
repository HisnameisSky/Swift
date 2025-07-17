//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by 澄界 on 2025/07/17.
//

import SwiftUI

//構造体
struct ContentView: View {
    
    //依存される要素の概要欄
    //任意でCPUの意思を設定
    @State private var    appChoice: GameChoice = [.rock, .paper, .scissors].randomElement()!
    //ゲームの結果種類を設定（任意に設定）
    @State private var    expectedOutcome: GameOutcome = [.win, .lose].randomElement()!
    @State private var isPlayerCorrect: Bool = true
    //表示ステータス情報の設定
    @State private var    currentQuestion = 1
    @State private var    score = 0
    @State private var    scoreTitle = ""
    //通知の設定
    @State private var    isShowingScore = false
    @State private var    isShowingGameOver = false
    
    //一般停な定義
    let gameChoices: [GameChoice] = [.rock, .paper, .scissors]
    let gameOutcomes: [GameOutcome] = [.win, .tie, .lose]
    
    let questionAmount = 10
    
    //構造体の表示される内容
    var body: some View {
        
        //背景は真上に置く
        ZStack {
            LinearGradient(colors: [Color("BG-1"), Color("BG-2")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            //題名
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                Text("Question: \(currentQuestion)/\(questionAmount)")
                    .font(.title2)
                //画面の真ん中にある部分
                VStack(spacing: 40) {
                    VStack {
                        Text("CPU picked: \(appChoice.description)")
                        
                        HStack {
                            Text("Intentionally:")
                            Text(expectedOutcome.description)
                                .foregroundStyle(expectedOutcome == .win ? .green : .red )
                        }
                    }
                    .font(.title)
                    //選択肢に応じて通知が変わる
                    HStack(spacing: 30) {
                        ForEach(gameChoices, id: \.self) { gameChoice in
                            Button {
                                choiceTapped(gameChoice)
                            } label: {
                                Text(gameChoice.description)
                                    .font(.system(size: 60))
                                
                            }
                        }
                    }
                    //通知
                    .alert(scoreTitle, isPresented: $isShowingScore) {
                        Button("Continue", action: nextScenario)
                    } message: {
                        //通知の内容
                        isPlayerCorrect ? (
                            Text("Correct, +1! Your score is now \(score).")
                        ) : (
                            Text("Incorrect, -1! Your score is now \(score).")
                        )
                    }
                }
                //VStackの追加特徴
                .padding(.vertical, 60)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                //VStackの下にある判定
                Text("Score: \(score)")
                    .font(.title.bold())
                    .alert("Game over!", isPresented: $isShowingGameOver) {
                    } message: {
                        Text("Your final score is \(score).")
                    }
            }
            //最初のVStackの追加特徴
            .foregroundStyle(.primary)
            .padding()
        }
    }
    
    //作動する機能の設定
    //選択肢のうち一つを選ぶ分岐機能
    func choiceTapped(_ playerChoice: GameChoice) {
        var actualOutcome: GameOutcome
        
        switch (playerChoice, appChoice) {
            //勝つ場合
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            actualOutcome = .win
            //試す場合
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            actualOutcome = .tie
            //負ける場合
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            actualOutcome = .lose
        }
        //プレイヤーの選択肢次第の正誤判定
        isPlayerCorrect = expectedOutcome == actualOutcome
        scoreTitle = expectedOutcome == actualOutcome ? "Correct" : "Incorrect"
        score = expectedOutcome == actualOutcome ? score + 1 : score - 1
        
        isShowingScore = true
    }
    //次の状況に移る機能
    func nextScenario() {
        if currentQuestion != questionAmount {
            appChoice = GameChoice.allCases.randomElement()!
            expectedOutcome = [.win, .lose].randomElement()!
            
            currentQuestion += 1
            
        } else {
            isShowingGameOver = true
        }
    }
    //ゲーム初期化の機能
    func resetGame() {
        currentQuestion = 1
        score = 0
    }
}


//ゲームの選択肢の種類を判別
enum GameChoice: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
    
    var description: String {
        self.rawValue
    }
}

//ゲームの結果の種類を判別
enum GameOutcome: String {
    case win = "Win"
    case tie = "Tie"
    case lose = "Lose"
    
    var description: String {
        self.rawValue
    }
}

#Preview {
    ContentView()
}
