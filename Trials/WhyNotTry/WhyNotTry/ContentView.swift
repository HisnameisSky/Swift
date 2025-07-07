//
//  ContentView.swift
//  WhyNotTry
//
//  Created by 澄界 on 2025/07/07.
//

import SwiftUI

struct ContentView: View {
    //活動の種類に定義を追加
    var activities = ["Archery", "Baseball", "Basketball", "Bowling", "Boxing", "Cricket", "Curling", "Fencing", "Golf", "Hiking", "Lacrosse", "Rugby", "Squash"]
    var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    //定義を設定
    @State private var selected = "Baseball"
    @State private var id = 1

    
    var body: some View {
        VStack {
            
            //本文を表示
            Text("Why not try…")
                .font(.largeTitle.bold())
            
            Spacer()
            
            VStack {
                //円の方の特徴など
                Circle()
                
                    .fill(colors.randomElement() ?? .blue)
                    .padding(50)
                    .overlay(
                        Image(systemName: "figure.\(selected.lowercased())")
                            .font(.system(size: 144))
                            .foregroundColor(.white)
                        
                    )
                //本文を表示
                Text("\(selected)")
                    .font(.title)
                    
            }
            //動的な効果を追加
            .transition(.slide)
            .id(id)
            
            Spacer()
            
            //ボタンを追加
            Button("Try again") {
                //ボタンにアニメーションを追加
                withAnimation(.easeInOut(duration: 1.0)){
                    selected = activities.randomElement() ?? "Archery"
                    id += 1
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
