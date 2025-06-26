//
//  ContentView.swift
//  Glow
//
//  Created by 澄界 on 2025/06/24.
//

import SwiftUI

struct AnimatedGradientTextView: View {
    @State var animate = false
    
    let grandientColors: [Color] = [ .yellow.opacity(0.1),.mint.opacity(0.2),.yellow.opacity(0.1),.purple,.orange,.pink,.purple,.cyan,.purple,.pink,.orange,.yellow.opacity(0.1),.mint.opacity(0.2),.yellow.opacity(0.1),
    ]
    
    var body: some View {
        ZStack {
            LinearGradient (
                gradient: Gradient(colors: grandientColors),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: UIScreen.main.bounds.width * 8.9, height: 400)
            
            .offset(x: animate ? UIScreen.main.bounds.width * -3.4 : UIScreen.main.bounds.width * 4.0)
            
            .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: animate)
            .rotationEffect(.degrees(20))
            .rotationEffect(.degrees(180))
            .onAppear { animate = true }
            .mask {
                Text("‧˚₊*̥(* ⁰̷̴͈꒨⁰̷̴͈)‧˚₊*̥\n\n(。=｀ω´=)ぇ?\n\n☆٩(｡•ω<｡)و ").font(.system(size: 40, weight: .bold))
            }
        }
    }
}
    
    #Preview {
        AnimatedGradientTextView()
    }
