//
//  ContentView.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import SwiftUI

struct ContentView: View {
    
    //外部リンクの情報を処理できるようにするプロパティ
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var cachedUsers: FetchedResults<CachedUser>
    //別のclassへのアクセス
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(cachedUsers) { cachedUser in
                    NavigationLink {
                        UserDetailView(cachedUser: cachedUser)
                    } label : {
                        HStack {
                            //アクティビティに応じて変わるまどかの色
                            Circle()
                                .fill(
                                    cachedUser.isActive ? StatusColor.online : StatusColor.offline
                                )
                                .frame(width: 20, height: 20)
                            
                            Text(cachedUser.wrappedName)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
        //FriendやUsersを展示するように設定
        .onAppear {
            
            userViewModel.fetchUsers(context: context)
        }
    }
}
