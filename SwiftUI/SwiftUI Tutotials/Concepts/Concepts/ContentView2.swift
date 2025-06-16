//
//  ContentView2.swift
//  Concepts
//
//  Created by 澄界 on 2025/06/17.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        HStack {
            Image(systemName: "folder.badge.plus")
            Image(systemName: "heart.circle.fill")
            Image(systemName: "alarm")
        }
        .symbolRenderingMode(.multicolor)
        .font(.largeTitle)
    }
}



#Preview {
    ContentView2()
}
