//
//  Post.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import Foundation

//[](:.)投稿の構造体
struct Post: Identifiable {
    let id = UUID()
    let user: User
    let postImage: String
    let caption: String
    let likes: String
    let hasLiked: Bool = false
    let hasBookmarked: Bool = false
}
