//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by 澄界 on 2025/07/25.
//

import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
