//
//  MessagesContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI
//[](:.)メッセージ画面の構造体
struct MessagesContainerView: View {
    
    var body: some View {
    
        NavigationView {
            Text("Hello, Messages!")
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Pankaj Gaikar")
                            .font(Font.system(size: 20, weight: .bold))
                            .padding()
                            .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                    }
//                    ツールバーの設定
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Image(systemName: "video")
                                .resizable()
                                .scaledToFit()
                                .font(.system(size: 20))
                                .padding(.trailing, 10)
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .font(.system(size: 20))
                        }
                    }
                })
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MessagesContainerView()
}
