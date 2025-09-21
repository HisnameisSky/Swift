//
//  BackgroundView.swift
//  Weather
//
//  Created by 澄界 on 2025/09/21.
//

import SwiftUI

struct BackgroundView: View {
    var isDay: Bool
    var topColor: Color {
        isDay ? . blue : .black
    }
    var bottomColor: Color {
        isDay ? .lightBlue : .gray
    }
    
    var body: some View {
//        任意の装飾？？
//        LinearGradient(
//                        gradient: Gradient(colors: [topColor, bottomColor]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                        .ignoresSafeArea()
        
        ContainerRelativeShape()
            .fill(isDay ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}
