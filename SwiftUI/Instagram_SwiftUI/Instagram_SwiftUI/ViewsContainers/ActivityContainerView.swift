//
//  ActivityContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI

//[](:.)
struct ActivityContainerView: View {
    var body: some View {
        NavigationView {
//            スクロール動作に反する構造
            ScrollView(.vertical, showsIndicators: false) {
//                情報ずつの設定
                ForEach(MockData().activity) {
                    ActivityView(activity: $0)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
//            ツールバーの設定
            .toolbar(content: {
                
                Text("Activity")
                    .font(Font.system(size: 20, weight: .bold))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
            })
        }
    }
}

#Preview {
    ActivityContainerView()
}
