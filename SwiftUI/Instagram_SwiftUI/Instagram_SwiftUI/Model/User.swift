//
//  User.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import Foundation

//[](:.)ユーザー情報の構造体
struct User: Identifiable {
    var id = UUID()
    let userName: String
    let userImage: String
}
