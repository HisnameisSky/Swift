//
//  MainView.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI

//[](:.)
struct MainView: View {
    var body: some View {
//        Tab標識の構造表示
        TabView {
//            ContentViewによる情報
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
//            OrderViewによる情報
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
