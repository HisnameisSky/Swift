//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 澄界 on 2025/07/17.
//

import SwiftUI

//一般的な構造体
struct ContentView: View {
    
    //構造体の中
    var body: some View {
        
        //色々混ぜ込める形
        ZStack {
            
            //真後ろの背景設定
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            //スマホ端末に合っている形
            VStack(spacing:20) {
                
                Text("This is prominent title")
                    //⇣別の作っておいた構造体による拡張の機能を借りる
                    .prominentTitle()
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                Text("Some text")
                    //SwiftCoreによる機能を借りる
                    .modifier(CustomCapsule(color: .blue))
                
                
                Text("Some other text")
                    //⇣別の作っておいた構造体による拡張の機能を借りる
                    .customCapsule(color: .green)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 80)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
            .padding(.horizontal)
        }
    }
}

//作り上げた構造体
struct CustomCapsule: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        //構造体の機能おける特徴・内容
        content
            .padding()
            .foregroundStyle(.white)
            .padding()
            .background(color)
            .clipShape(Capsule())
    }
}

//作り上げた構造体
struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        //構造体の機能おける特徴・内容
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

//作り上げた構造体の拡張機能
extension View {
    func customCapsule(color: Color) -> some View {
        //前に作った構造体の定義を借りる
        modifier(CustomCapsule(color: color))
    }
    func prominentTitle() -> some View {
        //前に作った構造体の定義を借りる
        modifier(ProminentTitle())
    }
}




#Preview {
    ContentView()
}
