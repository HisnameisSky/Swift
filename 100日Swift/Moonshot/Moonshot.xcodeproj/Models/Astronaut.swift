//
//  Astronaut.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import Foundation

//[Astronaut.]の構造
struct Astronaut: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    static let allAstronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
}
