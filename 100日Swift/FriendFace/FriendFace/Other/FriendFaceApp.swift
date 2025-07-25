//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     dataController.container.viewContext
                )
        }
    }
}
