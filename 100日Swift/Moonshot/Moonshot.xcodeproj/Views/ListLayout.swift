//
//  ListLayout.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//[ListLayout.]
struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        return List {
            //任務ずつの設定
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.vertical)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            
                            Text(mission.abbreviatedLaunchDate)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
            .listRowSeparatorTint(.lightBackground)
        }
        .background(.darkBackground)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ListLayout(
        astronauts: Astronaut.allAstronauts,
        missions: Mission.allMissions
    )
    .preferredColorScheme(.dark)
}
