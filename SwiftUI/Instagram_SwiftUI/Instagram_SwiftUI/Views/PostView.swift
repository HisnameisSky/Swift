//
//  PostView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI

//[](:.)
struct PostView: View {
    
    let post: Post
    let screenWidth: CGFloat
    
    var body: some View {
        VStack {
            
            //投稿の情報
            HStack {
                Image(post.user.userImage)
                    .resizable()
                    .cornerRadius(12.5)
                    .frame(width: 25, height: 25)
                    .padding(.leading, 10)
                
                Text(post.user.userName)
                    .font(Font.system(size: 14, weight: .semibold))
                
                Spacer()
                Image("menu")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
            }
            .frame(height: 25)
            
            //画像
            Image(post.postImage)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenWidth * 1.1)
                .clipped()
            
            //多機能のメニュー
            HStack {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                    .padding(.leading, 10)
                Image(systemName: "bubble.right")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Spacer()
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .padding(.trailing, 10)
            }
            .frame(height: 20)
            VStack(alignment: .leading, spacing: 0){
                Group {
                    Text(post.user.userName)
                        .font(Font.system(size: 14, weight: .semibold))
                    + Text(" ")
                    + Text(post.caption)
                        .font(Font.system(size: 14))
                }
                .padding(.horizontal, 15)
            }
            .frame(maxWidth: screenWidth, maxHeight: 60, alignment: .leading)
            Text(post.likes)
                .font(Font.system(size: 14, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .frame(width: screenWidth, height: 15, alignment: .leading)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        PostView(post: MockData().posts.first!, screenWidth: geometry.size.width)
    }
}
