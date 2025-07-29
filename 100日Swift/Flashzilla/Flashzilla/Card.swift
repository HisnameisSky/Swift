//
//  Card.swift
//  Flashzilla
//
//  Created by 澄界 on 2025/07/30.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is a capital city of Australia?", answer: "Canberra")
}
