//
//  Resort.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import Foundation

//[.](:.)
struct Resort: Codable, Identifiable, Comparable {
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    //発動しなければ現れない機能
    static func <(lhs: Resort, rhs: Resort) -> Bool {
        return lhs.name < rhs.name
    }
    static let allResorts: [Resort] = Bundle.main.decode(file: "resorts.json")
        static let example = allResorts[0]
}
