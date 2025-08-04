//
//  ContentView.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI

//[](:.)
struct ContentView: View {
//    変数
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
//        表示の構造
        NavigationStack {
//            リスト標識表示
            List {
//                項目ずつの設定
                ForEach(menu) { section in
                    Section(section.name) {
                        ForEach(section.items) { item in
                            NavigationLink(value: item) {
//                                ItemRowのViewによる情報と機能
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
//            別のViewへと案内
            .navigationDestination(for: MenuItem.self) { item in
                ItemDetail(item: item)
            }
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
