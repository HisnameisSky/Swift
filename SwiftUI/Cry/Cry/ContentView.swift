//
//  ContentView.swift
//  Cry
//
//  Created by 澄界 on 2025/05/17.
//

import SwiftUI

struct ContentView: View {
    //Comment　批評・一言
    /*criticalHitValue = 0 -rn */
    @State var cryText = "鳴き声"
    
    var body: some View {
        VStack {
            Text(cryText)
            HStack {
                //ボタン機能
                Button("😺") {
                    //Crytextをにゃにゃに書き換えるか
                    //表示本文の機能です
                    cryText = "にゃあにゃあ♪"
                }
                Button("🐶") {
                    cryText = "わんわん♪"
                }
                /*言いたいことがこれまでかw*/
                Button("🐸") {
                    cryText = "ケロケロ♬"
                }
                Button("🐘") {
                    cryText = "バオーん♬"
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .font(.title)
    }
}

#Preview {
    ContentView()
}
