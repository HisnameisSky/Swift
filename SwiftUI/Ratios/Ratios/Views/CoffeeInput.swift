//
//  CoffeeInput.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import Foundation
import SwiftUI
import Combine

//珈琲の数量構造体の設定[.]
struct CoffeeInput: View {
    
    @Binding var amount: String
    
    var body: some View {
        VStack {
            Text("How much coffee?")
                .bold()
                .fixedSize()
                .foregroundColor(Color("Text"))
                .font(.system(size: 24))
            
            TextField("", text: $amount)
                .frame(width: CGFloat(150), height: CGFloat(39))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Primary"), lineWidth: 3)
                )
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .onReceive(Just(amount)) { newValue in
                    
                    
                    
                    let filtered = newValue.filter { "0123456789.0".contains($0) }
                    if filtered != newValue {
                        self.amount = filtered
                    }
                }
            
            
            Text("grams")
                .fixedSize()
                .foregroundColor(Color("Text"))
                .font(.system(size: 14))
            
        }
    }
}
