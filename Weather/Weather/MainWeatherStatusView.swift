//
//  MainWeatherStatusView.swift
//  Weather
//
//  Created by 澄界 on 2025/09/21.
//

import SwiftUI

struct MainWeatherStatusView: View {
    var weatherType: WeatherType
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: weatherType.icon)
                .symbolRenderingMode(.multicolor)
            //                .symbolRenderingMode(.palette)
            //                .foregroundStyle(.red, .lightBlue, .pink)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(
                    .system(
                        size: 70,
                        weight: .medium
                    )
                )
                .foregroundColor(.white)
        }
    }
}
