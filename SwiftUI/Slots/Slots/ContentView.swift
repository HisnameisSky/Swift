//
//  ContentView.swift
//  Slots
//
//  Created by 澄界 on 2025/07/09.
//

import SwiftUI

struct ContentView: View {
    
    //物事の定義
    private var symbols = ["apple", "star", "cherry"]
    private var betAmount = 5
    @State private var numbers = [1, 2, 0]
    @State private var credits = 1000
    
    
    var body: some View {
        
        ZStack {
        
            //背景
            Rectangle()
                .foregroundColor(Color(red:200/255, green:143/255, blue:32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green:195/255, blue:76/255))
                .rotationEffect(.degrees(45))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                //題名
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "Star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                //クレジット回数情報を収集
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                //カード
                HStack {
                    Spacer()
                    Image(symbols[numbers[0]])
                        .resizable()
                        .aspectRatio(1,contentMode:
                                .fit)
                        .background(Color.white
                            .opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[1]])
                        .resizable()
                        .aspectRatio(1,contentMode:
                                .fit)
                        .background(Color.white
                            .opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[2]])
                        .resizable()
                        .aspectRatio(1,contentMode:
                                .fit)
                        .background(Color.white
                            .opacity(0.5))
                        .cornerRadius(20)
                    Spacer()
                }
                
                Spacer()
            //ボタン
                Button(action: {
                    //画像を変更
                    self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
                    
                    //勝敗を確認
                    if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]{
                        
                        //勝ち
                        self.credits += self.betAmount * 10
                    } else {
                        self.credits -= self.betAmount
                    }

                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(20)
                }
                Spacer()
                    
                }
            }
        }
    }


#Preview {
    ContentView()
}
