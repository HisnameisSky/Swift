//
//  Story.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import Foundation

//[](:.)ストーリー構造体
struct Story: Identifiable {
    let id = UUID()
    let user: User
    var hasSeen: Bool = false
    var isMyStory: Bool = false
}
