//
//  ContentView6.swift
//  Concepts
//
//  Created by 澄界 on 2025/06/17.
//

import SwiftUI

struct ContentView6: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.blue)
            Circle()
                .foregroundStyle(.orange)
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundStyle(.green)
            
        }
        .aspectRatio(3.0, contentMode: .fit)
    }
}

#Preview {
    ContentView6()
}
