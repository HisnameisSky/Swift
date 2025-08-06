//
//  ReelsContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI
import AVKit
//[](:.)
struct ReelsContainerView: View {
//    依存される変数
    @State private var index = 0
    @State private var top = 0
    @State private var videos = MockData().videos
    
    var body: some View{
        ZStack{
            PlayerPageView(videos: self.$videos)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
//        全画面に広がる設定
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ReelsContainerView()
}
