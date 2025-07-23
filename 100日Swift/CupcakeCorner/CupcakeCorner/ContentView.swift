//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 澄界 on 2025/07/23.
//

import SwiftUI

//最初に見る画面
struct ContentView: View {
    
    //依存される要素→[Order.]のclassを参照
    @StateObject var orderObject = OrderObject()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker(
                        "ケーキ種類の選択",
                        selection: $orderObject.order.type
                    ) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper(
                        "ケーキの数量: \(orderObject.order.quantity)",
                        value: $orderObject.order.quantity,
                        in: 3...20
                    )
                }
                
                Section {
                    Toggle("特殊な依頼がございますか?",
                           isOn: $orderObject.order.specialRequestEnabled
                        .animation())
                    
                    if orderObject.order.specialRequestEnabled {
                        Toggle("Extra frosting状態",
                               isOn: $orderObject.order.extraFrosting)
                        
                        Toggle("Sprinklesを追加",
                               isOn: $orderObject.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("ご注文の詳細") {
                        AddressView(orderObject: orderObject)
                    }
                }
            }
            .navigationTitle("カップケーキのコーナー")
        }
    }
}

#Preview {
    ContentView()
}
