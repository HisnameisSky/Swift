//
//  ContentView.swift
//  Concepts
//
//  Created by 澄界 on 2025/06/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("Hamlet")
                .font(.largeTitle)
            Text("by William Shakespeare")
                .font(.caption)
                .italic()
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
