//
//  WeatherButton.swift
//  Weather
//
//  Created by 澄界 on 2025/09/21.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    @Binding var isDay: Bool
    
    var body: some View {
        Button() {
            withAnimation {
                isDay.toggle()
            }
        } label: {
            Text(title)
                .frame(width: 280, height: 50)
                .background(backgroundColor.gradient)
                .foregroundColor(textColor)
                .font(
                    .system(
                        size: 20,
                        weight: .medium,
                        design: .default
                    )
                )
                .cornerRadius(10)
        }
        .padding(.bottom, 25)
    }
}
