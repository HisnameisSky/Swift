//
//  ContentView.swift
//  TicTacToe1
//
//  Created by 澄界 on 2025/07/12.
//

import SwiftUI

struct ContentView: View {
    
    //依存される要素の概要欄
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    //通知ボタンの機能を設定
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        VStack {
            //題名の設定
            Text("三目並べ")
                .bold()
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            
            //四角い一つずつの設定
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
            //ゲームオーバーの通知を設定
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("ゲームオーバー"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "あなたの勝ち♬": "CPUの勝ち！" : "引き分け？！" ) , dismissButton: Alert.Button.destructive(Text("良し"), action: {
                self.ticTacToeModel.resetGame()
            }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
