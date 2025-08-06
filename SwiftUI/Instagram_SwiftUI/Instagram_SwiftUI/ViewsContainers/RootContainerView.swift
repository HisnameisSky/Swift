//
//  RootContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI

//[](:.)開始画面
struct RootContainerView: View {
    @State private var selectedView = 0
    
    var body: some View {
        //典型的なSNS画面の設計
        TabView(selection: $selectedView) {
//            別Viewの構造体を借りて表示する設計
            TimeLineContainerView()
                .tabItem {
                    selectedView == 0 ?
                    Image(systemName: "house.fill") : Image(systemName: "house")
                }
                .tag(0)
            SearchContainerView()
                .tabItem {
                    selectedView == 1 ? Image(systemName: "magnifyingglass") : Image(systemName: "magnifyingglass")
                }
                .tag(1)
            ReelsContainerView()
                .tabItem {
                    selectedView == 2 ? Image(systemName: "film.fill") : Image(systemName: "film")
                }
                .tag(2)
            ActivityContainerView()
                .tabItem {
                    selectedView == 3 ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                }
                .tag(3)
            ProfileContainerView()
                .tabItem {
                    selectedView == 4 ? Image(systemName: "person.circle.fill") : Image(systemName: "person.circle")
                }
                .tag(4)
        }
    }
}

#Preview {
    RootContainerView()
}
