//
//  EmptyImagePlaceholder.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import SwiftUI

//画像を選べる画面の構造体[]()
struct EmptyImagePlaceholder: View {
    let color: Color
    
    var body: some View {
        ZStack {
            //形式
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    color,
                    style: .init(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [5, 5])
                )
                .scaledToFit()
            //
            Text("Tap to select an image")
                .foregroundColor(color)
                .font(.headline)
        }
    }
}

//表示専用
struct EmptyImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImagePlaceholder(color: .blue)
    }
}
