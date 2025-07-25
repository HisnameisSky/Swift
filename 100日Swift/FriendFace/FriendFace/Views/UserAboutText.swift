//
//  UserAboutText.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import SwiftUI

//[].ユーザーの情報
struct UserAboutText: View {
    let cachedUser: CachedUser
    
    var body: some View {
        Text(cachedUser.wrappedAbout)
            .padding()
            .navigationTitle("About \(cachedUser.wrappedName)")
            .navigationBarTitleDisplayMode(.inline)
    }
}
