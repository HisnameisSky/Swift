//
//  Video.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import Foundation
import AVFoundation

//[](:.)撮影動画の情報の構造体
struct Video : Identifiable {
    var id = UUID()
    var player : AVPlayer
    var likes: String
    var comments: String
    var caption: String
    var user: User
}
