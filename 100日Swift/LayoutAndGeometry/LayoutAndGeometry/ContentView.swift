//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by 澄界 on 2025/07/30.
//

import SwiftUI

struct ContentView: View {
    
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        
        //一つの変数による形成
        GeometryReader { fullView in
            //スクロール・上に吹く動作に反応する形成
            ScrollView(.vertical) {
                //行列一つずつの設定
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        //行列個別の本文
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                        //背景
                            .background(Color(hue: min(proxy.frame(in: .global).minY/800, 1.0), saturation: min(8.0 - proxy.frame(in: .global).maxY/100, 1.0), brightness: 1.0))
                        //立体感のある歯科医による効果
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                        //追加のこうか
                            .opacity(proxy.frame(in: .global).minY/200)
                            .scaleEffect(max(proxy
                                .frame(in: .global).maxY/400, 0.5))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
