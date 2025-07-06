//
//  GameState.swift
//  TicTacToe0
//
//  Created by 澄界 on 2025/07/06.
//

import Foundation
//ゲームアプリの依存されている要素を決める
class GameState: ObservableObject {
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    
    init() {
        resetBoard()
    }
    
    //順番の通知を表示する機能
    func turnText() -> String {
        return turn == Tile.Cross ? "Turn X" : "Turn O"
    }
    
    //勝敗の条件を決める
    func checkForVictory() -> Bool {
        if isTurnTile(0,0) && isTurnTile(1,0) && isTurnTile(2,0) {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        if isTurnTile(0,0) && isTurnTile(0,1) && isTurnTile(0,2) {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        
        if isTurnTile(0,0) && isTurnTile(1,1) && isTurnTile(2,2) {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
            return true
        }
        return false
    }
    
    //タイルの変更を表示
    func isTurnTile(_ row: Int, _ column: Int) -> Bool {
        return board[row][column].tile == turn
        
    }
    
    //ゲーム復元の機能
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...2 {
            var row = [Cell]()
            for _ in 0...2 {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    
    //タイルを選んで一定の条件による埋め込み
    func placeTile(_ row:Int,_ column : Int) {
        if(board[row][column].tile != Tile.Empty) {
            return
        }
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if(checkForVictory()) {
            if(turn == Tile.Cross){
                crossesScore += 1
            } else {
                noughtScore += 1
            }
            let winner = turn == Tile.Cross ? "Cross" : "Nought"
            alertMessage = "\(winner) wins!"
            showAlert = true
        } else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        if(checkForDraw()) {
            alertMessage = "Draw!"
            showAlert = true
        }
    }
    
    //引き分けの条件の決定機能
    func checkForDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.tile == Tile.Empty {
                    return false
                }
            }
        }
        return true
    }
}



