//
//  Friend.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import Foundation
//[].定義の並び
struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
