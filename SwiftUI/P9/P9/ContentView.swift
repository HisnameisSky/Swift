//
//  ContentView.swift
//  P9
//
//  Created by 澄界 on 2025/06/05.
//

import SwiftUI


struct ContentView: View {
    
    @State var isShowAlert: Bool = false
    @State var isShowDialog: Bool = false
    
    var body: some View {
        VStack {
            Button("アラート") {
                isShowAlert = true
                
            }
            .padding()
            
            Button("ダイヤログ") {
                isShowDialog = true
                
            }
            .padding()
            
        }
        .padding()
        .alert("本当に削除しますか？", isPresented: $isShowAlert) {
            Button ("削除する", role: .destructive) {
                
            }
            Button ("キャンセル", role: .cancel) {
                
            }
        } message: {
            Text("一度削除したら取り戻せなくなります。")
        }
        .confirmationDialog("ダイヤログ", isPresented: $isShowDialog, titleVisibility: .visible) {
            Button ("選択肢１") {
                
            }
            Button ("選択肢２") {
                
            }
            Button ("選択肢３") {
                
            }
            Button ("選択肢４") {
                
            }
            Button ("キャンセル", role: .cancel) {
                
            }
        } message: {
            Text("ここに伝言！")
            
        }
    }
}


#Preview {
    ContentView()
}
