//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by 澄界 on 2025/07/02.
//

import SwiftUI
final class TicTacToeViewModel: ObservableObject {
    
    //グリッドの特徴を決める
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),]
    
    //依存されている要素を設定
    @Published var moves:[TicTacToeView.Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled:Bool = false
    @Published var alertItem: AlertItem?
    
   //プレイヤー側の動きを検討する機能、勝敗条件に関係あり
    func processPlayerMove(for position:Int) {
        
       
        if isSquareOccupied(in: moves, forIndex: position) {
            return
        }
        
        
        moves[position] = TicTacToeView.Move(player: .human, boarderIndex: position)
        
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContent.humanWins
            return
        }
        
        
        if checkForDraw(in: moves) {
            alertItem = AlertContent.draw
            return
        }
        
        isGameBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = TicTacToeView.Move(player:.computer, boarderIndex: computerPosition)
            isGameBoardDisabled = false
            
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContent.computerWins
                return
            }
            
            
            if checkForDraw(in: moves) {
                alertItem = AlertContent.draw
                return
            }
        }
    }
    
   //
    func isSquareOccupied(in moves: [TicTacToeView.Move?], forIndex index: Int) -> Bool {
       
        return moves.contains(where: {$0?.boarderIndex == index})
    }
    
    //CPUの動きを設定
    func determineComputerMovePosition(in moves:[TicTacToeView.Move?]) -> Int {
        
        let occupiedIndices = Set(moves.compactMap { $0?.boarderIndex })
        let allIndices = Set(0..<9)
        let unoccupiedIndices = allIndices.subtracting(occupiedIndices)
        
        //CPUの動きを任意に設定する
        let randomIndex = unoccupiedIndices.randomElement()!
        return randomIndex
    }
    
    
    //勝利条件を決める
    func checkWinCondition(for player:TicTacToeView.Player, in moves:[TicTacToeView.Move?])->Bool{
        
        let winPatterns:Set<Set<Int>> = [[0,1,2],
                                         [3,4,5],
                                         [6,7,8],
                                         [0,3,6],
                                         [1,4,7],
                                         [2,5,8],
                                         [0,4,8],
                                         [2,4,6]]
        let playerMoves = moves.compactMap{$0}.filter {$0.player == player}
        let playerPositions = Set(playerMoves.map{$0.boarderIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){return true}
        
        return false
    }
    
    
    //引き分けの条件を決める機能
    func checkForDraw(in moves:[TicTacToeView.Move?])->Bool{
        
        return moves.compactMap{$0}.count == 9
    }
    
    //ゲーム復元を決める機能
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
}
