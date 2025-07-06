//
//  ContentView.swift
//  TicTacToe0
//
//  Created by 澄界 on 2025/07/06.
//

import SwiftUI

struct ContentView: View {
    //依存されている要素を決める
    @StateObject var gameState = GameState()
    
    var body: some View {
        let boardSize = CGFloat(5)
        
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .padding()
        Spacer()
        
        Text(String(format: "Crosses: %d", gameState.crossesScore))
            .font(.title)
            .bold()
            .padding()
        
        VStack(spacing: boardSize) {
            
            //縦式の行列の特徴を決める配列
            ForEach(0...2, id: \.self) {
                row in HStack(spacing: boardSize) {
                    ForEach(0...2, id: \.self) {
                        column in
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, column)
                            }
                    }
                }
            }
        }
        
        //⇧⬆️の共通の特徴
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert) {
            
            //
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton:  .default(Text("Okay")) {
                    gameState.resetBoard()
                }
            )
        }
        
        Text(String(format: "Noughts: %d", gameState.noughtScore))
            .font(.title)
            .bold()
            .padding()
        Spacer()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
