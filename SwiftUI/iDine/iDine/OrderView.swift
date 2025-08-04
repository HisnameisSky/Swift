//
//  OrderView.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI

//[.]({:.})、「Order」の画面
struct OrderView: View {
//    別のViewによる変数
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
//                    削除する時の機能
                    .onDelete(perform: deleteItems)
                }
                
                Section {
                    NavigationLink("Place Order") {
                        CheckoutView()
                    }
                }
                .disabled(order.items.isEmpty)
            }
            .navigationTitle("Order")
            .listStyle(.insetGrouped)
//            右上の編集ボタン
            .toolbar {
                EditButton()
            }
        }
    }
//    削除の機能
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
