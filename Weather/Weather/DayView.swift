//
//  DayView.swift
//  Weather
//
//  Created by 澄界 on 2025/09/21.
//

import SwiftUI

struct DayView: View {
    let day: Day
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(day.name.shortName)
                .font(
                    .system(
                        size: 16,
                        weight: .medium,
                        design: .default
                    )
                )
            foregroundColor(.white)
            
            Image(systemName: day.weather.icon)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28))
                .foregroundColor(.white)
        }
    }
}
