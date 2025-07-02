//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by 澄界 on 2025/07/02.
//

import SwiftUI
struct TicTacToeView: View {
    
    @StateObject private var viewModel = TicTacToeViewModel()
   
    let xImage = Image("XImage")
    let oImage = Image("OImage")
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
               
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                       
                        ZStack {
                          
                            Rectangle()
                                .foregroundColor(.blue).opacity(0.9)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/3-30,
                                       height: geometry.size.width/3-30)
                                .cornerRadius(10)
                            
                            
                            if let move = viewModel.moves[i] {
                                if move.player == .human {
                                    xImage
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                } else {
                                    oImage
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                    
                    Spacer()
                }
                
                .disabled(viewModel.isGameBoardDisabled)
               
                .padding()
                
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
                }
                
                Spacer()
            }
        }
    }
    
    enum Player {
        case human, computer
    }
    
    
    struct Move {
        let player: Player
        let boarderIndex: Int
        
        
        var indicator: String {
            return player == .human ? "xmark" : "circle"
        }
    }
    
    struct TicTacToeView_Previews: PreviewProvider {
        static var previews: some View {
            TicTacToeView()
        }
    }
}

