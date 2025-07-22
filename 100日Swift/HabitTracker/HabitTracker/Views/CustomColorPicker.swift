//
//  CustomColorPicker.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//[CustomColorPicker.()]　色選びの概要欄専用
struct CustomColorPicker: View {
    
    //依存される変数
    @Binding var selectedColor: Color
    
    private let colors: [Color] = [
        .red, .orange, .yellow, .green,
        .mint, .teal, .blue, .indigo,
        .purple, .pink, .gray, .brown
    ]
    
    private let columns = [
        GridItem(.adaptive(minimum: 60)),
    ]
    
    var body: some View {
        //適当に並べるグリッド
        LazyVGrid(columns: columns) {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    //形
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            selectedColor = color
                        }
                        .padding(10)
                    //色を選んだ時の変化設定
                    if selectedColor == color {
                        Circle()
                            .stroke(color, lineWidth: 5)
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
    }
}
//表示と実例
#Preview {
    @Previewable @State var selectedColor = Color.blue
    
    CustomColorPicker(
        selectedColor: $selectedColor
    )
    .padding()
}
