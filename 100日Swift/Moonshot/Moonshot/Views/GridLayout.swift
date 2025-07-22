//
//  GridLayout.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI



//[GridLayout.]
struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyHGrid(rows: columns) {
                //任務ずつの設定
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.abbreviatedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            // LazyVGridの追加
            .padding([.horizontal, .bottom])
        }
    }
}


//表示
#Preview {
    GridLayout(
        astronauts: Astronaut.allAstronauts,
        missions: Mission.allMissions
    )
    .background(.darkBackground)
    .preferredColorScheme(.dark)
}
