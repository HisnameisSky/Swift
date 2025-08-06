//
//  PostGridView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI
//[](:.)
struct PostGridView: View {
    
    let posts: [Post]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
//            投稿ずつの設定
            ForEach(posts) {
                Image($0.postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.width / 3)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(posts: MockData().posts)
}
