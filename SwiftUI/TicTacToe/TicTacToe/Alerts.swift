//
//  Alerts.swift
//  TicTacToe
//
//  Created by 澄界 on 2025/07/02.
//

import SwiftUI
//これは構造を検出可能なプロトコルに従うようにする
struct AlertItem: Identifiable {
    let id = UUID()
    //通知の題名を決める
    var title : Text
    //通知の伝言を決める
    var message : Text
    //通知の下に表れる
    var buttonTitle : Text
}

//通知の内容を決める配列
struct AlertContent {
    
    //プレイヤー側が勝者の場合
    static let humanWins = AlertItem(title: Text("You Win!"), message: Text("You have beaten the CPU"), buttonTitle: Text("Rematach"))
    
    //CPU端末側が勝者の場合
    static let computerWins = AlertItem(title: Text("You Lost!"), message: Text("The CPU has beaten you"), buttonTitle: Text("Rematach"))
    
    //引き分けの場合
    static let draw = AlertItem(title: Text("Draw!"), message: Text("It's a draw"), buttonTitle: Text("Rematach"))
    
}
