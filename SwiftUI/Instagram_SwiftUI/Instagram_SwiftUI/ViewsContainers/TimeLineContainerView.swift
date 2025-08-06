//
//  TimeLineContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI

//[](:.)
struct TimeLineContainerView: View {
    
    
    var body: some View {
//        スクロール動作に反応する設計
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MockData().stories) {
                            StoryView(story: $0)
                        }
                    }
                }
//                対象人物一人ずつの表示情報の設定
                ForEach(MockData().posts) {
                    PostView(post: $0, screenWidth: UIScreen.main.bounds.size.width)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar(content: {
//                上にずっと表示するツールバーの設定
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("instagram")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 130)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        NavigationLink(destination: MessagesContainerView()) {
                            Image(systemName: "message")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        
                    }
                }
            })
        }
    }
}


#Preview {
    TimeLineContainerView()
}
