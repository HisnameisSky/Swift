//
//  ContentView.swift
//  P8
//
//  Created by 澄界 on 2025/06/04.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @State var isShowContentView2 = false
    
    var body: some View {
        VStack {
            
            HStack {
                Button("-") {
                    // count = count - 1
                    count -= 1
                    
                }
                Text("Counter: \(count)")
                Button("+") {
                    // count = count + 1
                    count += 1
                }
            }
            .padding()
            Button ("ContentView2へ") {
                isShowContentView2 = true
            }
        }
        .font(.title)
        .sheet(isPresented: $isShowContentView2) {
            ContentView2(contentView2count: $count)
        }
    }
}


struct ContentView2: View {
    @Binding var contentView2count: Int
    
    var body: some View {
        Button("+10") {
            contentView2count += 10
        }
        .font(.title)
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
