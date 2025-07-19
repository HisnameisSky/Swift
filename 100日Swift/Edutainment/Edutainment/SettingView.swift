//
//  SettingView.swift
//  Edutainment
//
//  Created by 澄界 on 2025/07/20.
//

import SwiftUI


//設定のの表示される画面
//構造
struct SettingView: View {
    //変数
    @Binding var currentView: Int
    @Binding var numberOfTable: Int
    @Binding var numberOfQuestions: Int
    
    let numbersOfQuestions = [5, 10, 20, 40]
    //構造体
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            //質問
            Text("Which multiplication tables do you want to practice?")
                .font(.title2)
            //選択肢の形式
            Stepper("table of \(numberOfTable)", value: $numberOfTable, in: 1...11, step: 1)
            //
            Text("How many questions do you want to play?")
                .font(.title2)
            //選択肢の形式
            Picker("number of questions", selection: $numberOfQuestions, content: {
                ForEach(numbersOfQuestions, id: \.self) { number in
                    Text(number, format: .number)
                        .foregroundStyle(.secondary)
                }
            })
            //お飾り
            .pickerStyle(.segmented)
            Spacer()
            //ボタン
            Button(action: {
                currentView = 1
            }, label: {
                Label("Go to pop!", systemImage: "frying.pan.fill")
                    .font(.title)
            })
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .tint(.yellow)
            
        }
        .padding()
    }
}

#Preview {
    SettingView(currentView: .constant(1), numberOfTable: .constant(1), numberOfQuestions: .constant(1))
}
