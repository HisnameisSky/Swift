//
//  UserViewModel.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import CoreData
import Foundation
import SwiftUI

//外部リンクへの処理
class UserViewModel: ObservableObject {
    var users: [User] = []
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func fetchUsers(context: NSManagedObjectContext) {
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                DispatchQueue.main.async {
                    self.users = decodedUsers
                }
                
                Task {
                    await MainActor.run {
                        self.updateUsersCache(with: self.users, context: context)
                    }
                }
            } catch let decodeError {
                print("Error decoding users: \(decodeError.localizedDescription)")
            }
        }
        //情報収集が可能かどうかを確認してから処理の継続を許可
        task.resume()
    }
    //情報を更新する機能
    func updateUsersCache(
        with downloadedUsers: [User],
        context: NSManagedObjectContext
    ) {
        //情報の詳細
        for user in downloadedUsers {
            let cachedUser = CachedUser(context: context)
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: context)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToCachedFriends(cachedFriend)
            }
        }
        //情報の保存
        try? context.save()
    }
}
