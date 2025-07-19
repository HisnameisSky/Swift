//
//  ResultView.swift
//  Edutainment
//
//  Created by 澄界 on 2025/07/20.
//

import SwiftUI

//結果の表示される画面
//構造
struct ResultView: View {
    //変数
    @Binding var currentView: Int
    @Binding var score: Int
    //表示
    var body: some View {
        VStack {
            Spacer()
            //中央に写る画像
            Image(systemName: "popcorn.fill")
                .resizable()
                .frame(width: 100, height: 130)
                .foregroundColor(.yellow)
            //下に続くコメント
            Text("Yay! you made \(score) popcorns!")
                .font(.title2)
            Spacer()
            //質問とボタン
            Text("Do you want to pop again?")
            Button(action: {
                startNewGame()
            }, label: {
                Label("Go to pop!", systemImage: "frying.pan.fill")
                    .font(.title)
            })
            .buttonStyle(.bordered)
            .tint(.yellow)
        }
        .padding()
    }
    //ゲームを初期化する機能の設定
    func startNewGame() {
        score = 0
        currentView = 1
    }
}


#Preview {
    ResultView(currentView: .constant(2), score: .constant(4))
}
