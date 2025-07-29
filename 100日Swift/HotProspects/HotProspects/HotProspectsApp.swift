//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by 澄界 on 2025/07/29.
//

import SwiftUI


//写真の記録アプリ
@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //SwiftDataへと繋がる宣言
        .modelContainer(for: Prospect.self)
    }
}
