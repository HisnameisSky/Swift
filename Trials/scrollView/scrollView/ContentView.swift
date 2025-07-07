//
//  ContentView.swift
//  scrollView
//
//  Created by 澄界 on 2025/06/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let color: Color
    let nun: String
    
}


struct ContentView: View {
    let baseItems: [Item] = [
        .init(color: .red ,nun:"一"),.init(color: .blue ,nun:"二"),.init(color: .green ,nun:"三"),.init(color: .yellow ,nun:"四")
    ]
    
    let virtualCount = 10_000
    var startIndex: Int { virtualCount / 2}
    
    var body: some View {
        
        Spacer(minLength: 300)
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top) {
                        ForEach(0..<virtualCount, id: \.self) { i in
                            let item = baseItems[i % baseItems.count]
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(item.color)
                                    .frame(width: 150, height: 150)
                                Text(item.nun)
                                    .font(.system(size: 50))
                            } .id(i)
                        }
                    }
                } .safeAreaPadding(.leading,30)
                    .onAppear {
                        proxy.scrollTo(startIndex, anchor: .leading)
                    }
                
            }
        }
    }
}


#Preview {
    ContentView()
}
