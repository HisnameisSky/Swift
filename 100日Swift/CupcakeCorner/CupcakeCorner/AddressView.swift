//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by 澄界 on 2025/07/23.
//

import SwiftUI

//ご注文の詳細画面、[AddressView.]
struct AddressView: View {
    //Orderのclassの情報を参照
    @ObservedObject var orderObject: OrderObject
    
    var body: some View {
        //申込書類
        Form {
            Section("お届け先の情報") {
                TextField("お名前", text: $orderObject.order.name)
                TextField("お宅の住所", text: $orderObject.order.streetAddress)
                TextField("市街", text: $orderObject.order.city)
                TextField("番号", text: $orderObject.order.zip)
            }
            
            Section {
                NavigationLink("決済") {
                    CheckoutView(orderObject: orderObject)
                }
                .foregroundStyle(.blue)
            }
            .disabled(!orderObject.order.hasValidAddress)
        }
        //題名
        .navigationTitle("ご配達の情報")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(
            orderObject: OrderObject()
        )
    }
}
