//
//  Contentview3.swift
//  Concepts
//
//  Created by 澄界 on 2025/06/17.
//

import SwiftUI

struct Contentview3: View {
    var body: some View {
        Label("Favorite Books", systemImage: "books.vertical")
            .labelStyle(.titleAndIcon)
            .font(.largeTitle)
    }
}

#Preview {
    Contentview3()
}
