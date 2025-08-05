//
//  ContentView.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import SwiftUI

//[](:.)
struct ContentView: View {
    
    @State var coffee: String = ""
    @State var waterRatio: String = ""
//    CGFloat専用の変数
    private let spacingHeight: CGFloat = 20
    private let dividerWidth: CGFloat = 267
    private let bottomSpacerHeight: CGFloat = 100
    private let sidePadding: CGFloat = 80
    
    
    
    
    var body: some View {
    
        ScrollView {
            VStack {
                
                CoffeeInput(amount: $coffee)
                
                VStack {
                    Spacer()
                        .frame(height:spacingHeight)
                    
                    Divider()
                        .frame(width:dividerWidth)
                    
                    Spacer()
                        .frame(height:spacingHeight)
                }
                
                WaterInput(amount: $waterRatio)
                
                VStack {
                    Spacer()
                        .frame(height:spacingHeight)
                    
                    Divider()
                        .frame(width: dividerWidth)
                    
                    Spacer()
                        .frame(height:spacingHeight)
                }
                
                WaterDisplay(
                    waterRatio: $coffee,
                    coffee: $waterRatio
                )
                Spacer()
                    .frame(height:bottomSpacerHeight)
                
                TimerView()
                
            }.padding(sidePadding)
        }
    }
}

#Preview {
    ContentView()
}
