//
//  MissionView.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI


//[CrewMember.]の構造
struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
//MissionView.の構造
struct MissionView: View {
    @State private var rotationAngle: Angle = .zero
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometryProxy in
            
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometryProxy.size.width * 0.6)
                        .padding(.top)
                        .rotation3DEffect(rotationAngle,
                                          axis: (x: 0, y: 1, z: 0))
                        .onTapGesture {
                            withAnimation() {
                                rotationAngle = .degrees(360)
                            }
                            
                            rotationAngle = .zero
                        }
                    
                    Text("Tap me!")
                        .font(.caption)
                        .italic()
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        Text("Launch Date")
                            .sectionHeadingStyle()
                        
                        Text(mission.completeLaunchDate)
                        
                        CustomDivider()
                        
                        Text("Mission Highlights")
                            .sectionHeadingStyle()
                        
                        Text(mission.description)
                        
                        CustomDivider()
                        
                        Text("Crew")
                            .sectionHeadingStyle()
                    }
                    .padding(.horizontal)
                    
                    CrewScrollView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            // 人物の情報
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name).")
            }
        }
    }
}

//表示するように設定
#Preview {
    NavigationStack {
        MissionView(
            mission: Mission.allMissions[0],
            astronauts: Astronaut.allAstronauts
        )
    }
    .preferredColorScheme(.dark)
}

