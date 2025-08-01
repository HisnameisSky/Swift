//
//  ContentView.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import SwiftUI
//定義の選択肢種類
enum SortOrder {
    case `default`, alphabetical, byCountry
}
//[.](:.)
struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode(file: "resorts.json")
    //別のclass構造体によ変数
    @StateObject var favorites = Favorites()
    //依存される変数
    @State private var searchText = ""
    @State private var isShowingSortingOptions = false
    @State private var sortOrder = SortOrder.default
    
    //整理された場合の変数
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    //整理の設定における選択肢
    var sortedResorts: [Resort] {
        
        switch sortOrder {
            
        case .`default`:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .byCountry:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    //表示
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortsView(resorts: resorts, resort: resort)
                } label: {
                    ResortsView(resorts: resorts, resort: resort)
                }
            }
            .navigationTitle("Resorts")
            //検索機能の表示領域
            .searchable(text: $searchText, prompt: "Search for a resort")
            //矢印の情報整理の機能
            .toolbar {
                Button {
                    isShowingSortingOptions = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            //整理設定の表示
            .confirmationDialog("Sorting order", isPresented: $isShowingSortingOptions) {
                Button("Default") { sortOrder = .default }
                Button("Alphabetical") { sortOrder = .alphabetical }
                Button("By country") { sortOrder = .byCountry }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Choose sorting type:")
            }
            //歓迎画面のViewによる機能
            WelcomeView()
        }
               
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
