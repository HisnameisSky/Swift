//
//  ContentView.swift
//  Weather
//
//  Created by 澄界 on 2025/09/21.
//

import SwiftUI


struct City {
    let id = UUID()
    let name: String
    let weather: [Day]
}


struct ContentView: View {
    
    @State private var isDay: Bool = false
    
    var cities: [City] = [
        City(name: "Cupertino, CA", weather: []),
        City(name: "Ferndale, WA", weather: []),
        City(name: "Bellingham, WA", weather: []),
        City(name: "Kyiv, UA", weather: []),
        City(name: "Moscow, RU", weather: [])]
    
    var body: some View {
        
        ZStack {
            BackgroundView(isDay: isDay)
            
            TabView {
                ForEach(cities, id: \.id) { city in
                    CityView(isDay: $isDay, city: city)
                        .tabItem {
                            Label("\(city.name)", systemImage: "city")
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
