//
//  AstronautView.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//人物情報の表示AstronautView.
struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let name = "armstrong"
    
    NavigationStack {
        AstronautView(astronaut: Astronaut.allAstronauts[name]!)
            .preferredColorScheme(.dark)
    }
}
