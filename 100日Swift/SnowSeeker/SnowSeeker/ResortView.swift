//
//  ResortView.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import SwiftUI

//[.](:.)検索情報のバナー
struct ResortsView: View {
    //変化に敏感の変数
    @EnvironmentObject var favorites: Favorites
    //定義
    let resorts: [Resort]
    let resort: Resort
    
    var body: some View {
        
        HStack {
            Image(resort.country)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 25)
                .clipShape(
                    RoundedRectangle(cornerRadius: 5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(resort.name)
                    .font(.headline)
                
                Text("\(resort.runs) runs")
                    .foregroundColor(.secondary)
            }
            
            if favorites.contains(resort) {
                Spacer()
                
                Image(systemName: "heart.fill")
                //便利性の設定の起動に応じて表示の本文
                    .accessibilityLabel("This is a favorite resort")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ResortsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortsView(resorts: [], resort: Resort.example)
            .environmentObject(Favorites())
    }
}
