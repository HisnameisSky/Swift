//
//  ContentView.swift
//  HotProspects
//
//  Created by 澄界 on 2025/07/29.
//

import SwiftUI

//[].()
struct ContentView: View {
    var body: some View {
        //真下にあるツールバーの並び
        TabView {
            ProspectsView(filterType: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filterType: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filterType: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
