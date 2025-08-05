//
//  WaterDisplay.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import SwiftUI

//[](:.)
struct WaterDisplay: View {
    
    @Binding var waterRatio: String
    @Binding var coffee: String
    
    
    var body: some View {
        VStack {
            Text("You need")
                .fixedSize()
                .font(.system(size: 24))
            
            Text(
                String(
                    CalculatorViewModel.calculateGramsOfWaterTimes(
                        waterRatio: Grams(waterRatio) ?? 0.0,
                        coffee: Grams(coffee) ?? 0.0
                    )
                )
            )
            .fixedSize()
            .font(.system(size: 72))
            
            
            Text("grams of water")
                .fixedSize()
                .font(.system(size: 24))
        }
    }
}
