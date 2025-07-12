//
//  SquareView.swift
//  TicTacToe1
//
//  Created by 澄界 on 2025/07/12.
//

import Foundation
import SwiftUI


//四角いの状態を定義する
enum SquareStatus {
    case empty
    case home
    case visitor
}


//四角いの状態が監視されるように設定
class Square : ObservableObject {
    @Published var squareStatus : SquareStatus
    
    //変更に応じて状態が変わるように設定
    init(status : SquareStatus) {
        self.squareStatus = status
    }
}

//四角いをボタン形式にしてプレイヤーかCPUが押したのかの判定判別
struct SquareView : View {
    @ObservedObject var dataSource : Square
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .home ? "X" : self.dataSource.squareStatus == .visitor ? "0" : " ")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.black)
            .frame(width: 70, height: 70, alignment: .center)
            .background(Color.gray.opacity(0.3).cornerRadius(10))
            .padding(4)
        })
    }
}


