//
//  ContentView.swift
//  ScreenTransition
//
//  Created by 澄界 on 2025/05/28.
//

import SwiftUI

struct ContentView: View {
    @State var isShowScondView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ScondView()
                } label: {
                    Text("Second Viewへ遷移")
                }
                Button("Second Viewへモーダル遷移") {
                    isShowScondView = true
                    
                }
                .padding()
                .sheet(isPresented: $isShowScondView) {
                    ScondView ()
                        .presentationDetents([.medium])
                }
            }
            .padding()
            .navigationTitle("画面１")
        }
    }
}

#Preview {
    ContentView()
}
