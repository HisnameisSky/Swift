//
//  View-Modifier.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//SectionHeadingStyle.の構造
struct SectionHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

extension View {
    func sectionHeadingStyle() -> some View {
        modifier(SectionHeadingStyle())
    }
}
