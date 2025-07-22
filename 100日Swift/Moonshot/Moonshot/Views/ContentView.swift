//
//  ContentView.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//主に使われる画面
struct ContentView: View {
    @State private var isShowingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    GridLayout(
                        astronauts: Astronaut.allAstronauts,
                        missions: Mission.allMissions
                    )
                } else {
                    ListLayout(
                        astronauts: Astronaut.allAstronauts,
                        missions: Mission.allMissions
                    )
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button("Show as \(isShowingGrid ? "List" : "Grid")") {
                        isShowingGrid.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
