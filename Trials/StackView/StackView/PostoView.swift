//
//  PostoView.swift
//  StackView
//
//  Created by 澄界 on 2025/05/18.
//

import SwiftUI

struct PostoView: View {
    var body: some View {
        ZStack {
            Color.red.frame(width: 280, height: 300)
            VStack {
                HStack {
                    ZStack {
                        Color.gray.frame(width: 120, height: 100)
                        Color.black.frame(width: 100, height: 30)
                    }
                    ZStack {
                        Color.gray.frame(width: 120, height: 100)
                        Color.black.frame(width: 100, height: 30)
                    }
                }
                Color.white.frame(width: 80, height: 10)
                Color.white.frame(width: 100, height: 10)
                Color.white.frame(width: 10, height: 50)
            }
        }
        Color.red.frame(width: 30, height: 100)
        Color.gray.frame(width: 200, height: 30)
    }
}

#Preview {
    PostoView()
}
