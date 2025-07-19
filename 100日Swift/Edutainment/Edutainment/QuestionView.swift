//
//  QuestionView.swift
//  Edutainment
//
//  Created by 澄界 on 2025/07/20.
//

import SwiftUI

//質問の表示される画面
//構造
struct QuestionView: View {
    //変数
    @Binding var currentView: Int
    @Binding var numberOfQuestion: Int
    @Binding var numberOfTable: Int
    @Binding var score: Int
    @State var numberToMultiply = Int.random(in: 1...9)
    @State var textInput = 0
    @State var currentQuestion = 1.0
    //共通の変数(計算方程式)
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            //上の画面に写る過程判定とそれにまつわる要素
            ProgressView(value: currentQuestion, total: Double(numberOfQuestion)) {
                HStack {
                    Text("\(currentQuestion) / \(numberOfQuestion)")
                    Spacer()
                    Text("Score: \(score)")
                }
            }
            //お飾り
            .font(.title3)
            .tint(.yellow)
            Spacer()
            //中央に写る内容
            Text("\(numberOfTable) X \(numberToMultiply)")
            HStack {
                Text("=")
                TextField("answer", value: $textInput, formatter: QuestionView.numberFormatter)
                    .background()
                    .frame(maxWidth: 50)
                    .keyboardType(.numberPad)
            }
            Spacer()
            //真下のブタン
            Button(action: {
                guessAnswer(answer: textInput)
            }, label: {
                Label("Pop to next", systemImage: "fireworks")
            })
            .tint(.yellow)
            .buttonStyle(.bordered)
        }
        .font(.title)
        .padding()
    }
    //回答の判定機能
    func guessAnswer(answer: Int) {
        if answer == numberToMultiply * numberOfTable {
            score += 1
        }
        numberToMultiply = Int.random(in: 1...9)
        textInput = 0
        if currentQuestion == Double(numberOfQuestion) {
            currentView = 3
        } else {
            currentQuestion += 1
        }
    }
}

#Preview {
    QuestionView(currentView: .constant(1), numberOfQuestion: .constant(10), numberOfTable: .constant(9), score: .constant(2))
}
