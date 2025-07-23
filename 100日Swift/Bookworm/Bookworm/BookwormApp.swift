//
//  BookwormApp.swift
//  Bookworm
//
//  Created by 澄界 on 2025/07/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
