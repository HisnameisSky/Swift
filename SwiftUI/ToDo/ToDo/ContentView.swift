//
//  ContentView.swift
//  ToDo
//
//  Created by 澄界 on 2025/06/05.
//

import SwiftUI

struct ContentView: View {
    @State var taskData = [(title: "買い物をする", completed: false),
                           (title: "植物を養う", completed: false),
                           (title: "部屋を綺麗にする", completed: false),
                           (title: "読書の時間", completed: false)]
    //本文などを書いて使用者に主導源を握らせる仕様
    
    var body: some View {
        NavigationStack {
            List(0..<taskData.count, id: \.self) { index in
                Button {
                    taskData[index].completed.toggle()
                    //押せるようにする仕様
                    
                } label: {
                    HStack {
                        Image(systemName: taskData[index].completed == true ?
                              "checkmark.circle.fill" : "circle")
                        //条件に応じて変わる機能
                        
                        Text(taskData[index].title)
                        
                    }
                }
                .foregroundColor(.primary)
                //見づらい環境の解決法
                
            }
            .navigationTitle(Text("To Doリスト"))
        }
    }
}


#Preview {
    ContentView()
}
