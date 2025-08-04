//
//  iDineApp.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI


//[](:.)最初に起動する構造体
@main
struct iDineApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
