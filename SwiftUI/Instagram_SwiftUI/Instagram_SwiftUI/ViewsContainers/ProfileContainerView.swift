//
//  ProfileContainerView.swift
//  Instagram_SwiftUI
//
//  Created by 澄界 on 2025/08/07.
//

import SwiftUI
//[](:.)
struct ProfileContainerView: View {
    private let user: User = User(userName: "pankajgaikar", userImage: "user_16")
    
    var body: some View {
        
        NavigationView {
//            スクロース動作に反応する構造体
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
//                    SNSプロフィールの表示情報
                    ProfileHeader(user: user)
                    ProfileControlButtonsView()
                    ProfileMediaSelectionView()
                    PostGridView(posts: MockData().posts)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar(content: {
//                ツールバーの設定
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pankaj Gaikar")
                        .font(Font.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 25, height: 20)
                    }
                }
            })
        }
    }
}


#Preview {
    ProfileContainerView()
}
