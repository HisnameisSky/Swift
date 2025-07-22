//
//  Mission.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import Foundation


//[Mission.]の構造
struct Mission: Decodable, Identifiable {
    struct CrewRole: Decodable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    //.displayName
    var displayName: String { "Apollo \(id)" }
    
    var image: String { "apollo\(id)" }
    //.abbreviatedLaunchDate
    var abbreviatedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var completeLaunchDate: String {
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
    
    //別の書類よりの情報を適応する
    static let allMissions: [Mission] = Bundle.main.decode("missions.json")
}

