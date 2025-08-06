//
//  Activity.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import Foundation

//?.??他選択肢の構造体
enum ActivityType {
    case liked
    case newFollower
    case suggestFollower
    case comment
}
//[]({:.})機能
struct Activity: Identifiable {
    let id = UUID()
    let activity: ActivityType
    let duration: String //Easier to show on UI.
    let usersInContext: [User]
    let post: Post
    var comment: String = ""
    
    func getUsernames() -> String {
        return usersInContext.map{$0.userName}.joined(separator: ", ")
    }
}
