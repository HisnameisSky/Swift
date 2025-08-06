//
//  SearchContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI
//[](:.)検索画面の構造体
struct SearchContainerView: View {
    
    private let searchStrings: [String] = []
    @State private var searchText : String = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, placeholder: "Search")
            PostGridView(posts: MockData().posts)
        }
    }
}

#Preview {
    SearchContainerView()
}
